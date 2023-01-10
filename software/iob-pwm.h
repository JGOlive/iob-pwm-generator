#include <stdbool.h>

#include "iob_pwm_swreg.h"

//GPIO functions

//Set GPIO base address
void pwm_init(int base_address);

void pwm_set_period(uint8_t period);
