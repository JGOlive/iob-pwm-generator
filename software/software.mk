include $(PWM_DIR)/config.mk

PWM_SW_DIR:=$(PWM_DIR)/software

#include
INCLUDE+=-I$(PWM_SW_DIR)

#headers
HDR+=$(PWM_SW_DIR)/*.h iob_pwm_swreg.h

#sources
SRC+=$(PWM_SW_DIR)/iob-pwm.c

iob_pwm_swreg.h: $(PWM_DIR)/mkregs.conf
	$(MKREGS) iob_pwm $(PWM_DIR) SW
