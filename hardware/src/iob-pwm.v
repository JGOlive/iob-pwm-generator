`timescale 1ns/1ps

`include "iob_lib.vh"
`include "iob_pwm_swreg_def.vh"

module iob_pwm 
  # (
     parameter DATA_W = 32, //PARAM CPU data width
     parameter ADDR_W = `iob_pwm_swreg_ADDR_W //MACRO CPU address section width
     )
   (
   
   //CPU interface
`include "iob_s_if.vh"

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
   
   localparam ROM_ADDR_W = 7;
   localparam ROM_DATA_W = 16;
   
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
      
      
   localparam count_divider = 128;  //SPER 
   reg rom_counter_en;
   
   `IOB_VAR(freq_counter, 7);
   `IOB_VAR(rom_addr, ROM_ADDR_W);

   `IOB_MODCNT_R(clk, rst, 0, freq_counter, count_divider);
   `IOB_MODCNT_RE(clk, rst, 0, rom_counter_en, rom_addr, (2**ROM_ADDR_W - 1));

   assign rom_counter_en = (freq_counter == (count_divider - 1));
   assign rom_r_addr = rom_addr;
   
   //
   // READ BOOT ROM 
   //
   reg [ROM_ADDR_W-3: 0] rom_r_addr;
   wire [ROM_DATA_W-1: 0] rom_r_rdata;
   wire [ROM_DATA_W-1: 0] duty_cycle_converted_value;

   always @(posedge clk, posedge rst,)
     if (sine && rom_r_addr != (2**(`ROM_ADDR_W-2)-1))begin
       rom_r_addr <= rom_r_addr + 1'b1;
       duty_cycle_converted_value <= ((rom_r_rdata * count_divider) >> 16);
       end
      else begin
        rom_r_addr <= {`ROM_ADDR_W-2{1'b0}};
        duty_cycle_converted_value <= ((rom_r_rdata * count_divider) >> 16);
      end
      
    assign PWM_OUTPUT = (freq_counter <= ); 
    
    
endmodule
