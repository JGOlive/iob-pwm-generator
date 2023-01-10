ifeq ($(filter PWM, $(SW_MODULES)),)

SW_MODULES+=PWM

include $(PWM_DIR)/software/software.mk

# add embeded sources
SRC+=iob_pwm_swreg_emb.c

iob_pwm_swreg_emb.c: iob_pwm_swreg.h

endif
