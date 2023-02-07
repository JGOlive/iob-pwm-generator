`timescale 1ns/1ps

`include "iob_lib.vh"
`include "iob_pwm_swreg_def.vh"

module iob_pwm 
  # (
     parameter DATA_W = 32, //PARAM CPU data width
     parameter ADDR_W = `iob_pwm_swreg_ADDR_W, //MACRO CPU address section width
     parameter ROM_ADDR_W = 11,
     parameter ROM_DATA_W = 16,
     parameter PWM_PERIOD = 256
     )
   (
   
   //CPU interface
`include "iob_s_if.vh"
  output pwm_output,

    // inputs and outputs have dedicated interface
`include "iob_gen_if.vh"
    );

//BLOCK Register File & Configuration control and status register file.
`include "iob_pwm_swreg_gen.vh"

    // SWRegs
    `IOB_WIRE(PWM_SPER, `PWM_SPER_W)
    iob_reg #(.DATA_W(`PWM_SPER_W))
    pwm_set_period (
        .clk        (clk),
        .arst       (rst),
        .rst        (rst),
        .en         (PWM_SPER_en),
        .data_in    (PWM_SPER_wdata),
        .data_out   (PWM_SPER)
    );
    
   //
   //INSTANTIATE ROM
   //
   
  `IOB_VAR(freq_counter, 16)
  `IOB_VAR(rom_r_addr, ROM_ADDR_W)
  `IOB_VAR(rom_r_addr_mux, ROM_ADDR_W)
  `IOB_WIRE(rom_r_rdata, ROM_DATA_W)
  `IOB_WIRE(duty_cycle_converted_value, DATA_W)
  `IOB_WIRE(rom_r_valid, 1)

   
   iob_rom_sp
     #(
       .DATA_W(ROM_DATA_W),
       .ADDR_W(ROM_ADDR_W),
       .HEXFILE("sine.hex")
       )
   sp_rom0 
     (
      .clk(clk),
      .r_en(rom_r_valid),
      .addr(rom_r_addr),
      .r_data(rom_r_rdata)
      );
   wire freq_counter_en = 1;   
   reg rom_counter_en;
   
   `IOB_MODCNT_RE(clk, rst, 0, freq_counter_en, freq_counter, PWM_PERIOD)
   `IOB_MODCNT_RE(clk, rst, 0, rom_counter_en, rom_r_addr_mux, (2**ROM_ADDR_W - 1))
   
   assign rom_counter_en = (freq_counter == (PWM_PERIOD - 1));
   
   assign rom_r_addr = ((PWM_SPER * rom_r_addr_mux) % (2**ROM_ADDR_W - 1));

   assign rom_r_valid = 1'b1;

   assign pwm_output = (freq_counter >= rom_r_rdata);
    
    
endmodule
