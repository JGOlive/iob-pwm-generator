   //
   // PWM
   //

   iob_pwm pwm0
     (
      .clk     (clk),

      // Registers interface
      
      // CPU interface
      .valid   (slaves_req[`valid(`PWM)]),
      .address (slaves_req[`address(`PWM,`iob_pwm_swreg_ADDR_W+2)-2]),
      .wdata   (slaves_req[`wdata(`PWM)]),
      .wstrb   (slaves_req[`wstrb(`PWM)]),
      .rdata   (slaves_resp[`rdata(`PWM)]),
      .ready   (slaves_resp[`ready(`PWM)])
      );
