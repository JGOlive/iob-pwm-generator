`timescale 1ns / 1ps
// fpga4student.com: FPGA Projects, Verilog projects, VHDL projects 
// Verilog project: Verilog testbench code for PWM Generator with variable duty cycle 
module tb_PWM_Generator_Verilog;
 // Inputs
 reg clk;
 reg define_duty;
 // Outputs
 wire PWM_OUT;
 // Instantiate the PWM Generator with variable duty cycle in Verilog
 PWM_Generator_Verilog PWM_Generator_Unit(
  .clk(clk), 
  .define_duty(define_duty), 
  .PWM_OUT(PWM_OUT)
 );
 // Create 100Mhz clock
 initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end 
 initial begin
  #100; 
  defined_duty = 5; 
  #100;// increase duty cycle defined = 0;
  #defined = 7;
  #100;// increase duty cycle defined = 0;
  #defined = 9;
  #100;// increase duty cycle defined = 0;
  #defined = 9;
  #100;// increase duty cycle defined = 0;
  #defined = 7;
  #100;// increase duty cycle defined = 0;
  #defined = 5;
  #100;// increase duty cycle defined = 0;
  #defined = 2;
  #100;// increase duty cycle defined = 0;
  #defined = 0;
  #100;// increase duty cycle defined = 0;
  #defined = 0;
  #100;// increase duty cycle defined = 0;
  #defined = 2;
  #100;// increase duty cycle defined = 0;
 end
endmodule