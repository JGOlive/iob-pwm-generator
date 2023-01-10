#include "iob-pwm.h"

//GPIO functions

//Set pwm base address
void pwm_init(int base_address){
  IOB_PWM_INIT_BASEADDR(base_address);
}

//Set values on outputs
void pwm_set_period(uint8_t period){
  IOB_PWM_SET_SPER(period);
}
