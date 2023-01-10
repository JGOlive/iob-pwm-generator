/* PC Emulation of GPIO peripheral */

#include <stdint.h>
#include <stdio.h>

#include "iob_pwm_swreg.h"

static uint32_t base;

void PWM_INIT_BASEADDR(uint32_t addr) {
    base = addr;
    return;
}

void IOB_PWM_SET_SPER(uint8_t period){

}
