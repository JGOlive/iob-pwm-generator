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
endmodule
