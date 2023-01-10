ifeq ($(filter PWM, $(HW_MODULES)),)

include $(PWM_DIR)/config.mk

#add itself to HW_MODULES list
HW_MODULES+=PWM


PWM_INC_DIR:=$(PWM_HW_DIR)/include
PWM_SRC_DIR:=$(PWM_HW_DIR)/src


#include files
VHDR+=$(wildcard $(PWM_INC_DIR)/*.vh)
VHDR+=iob_pwm_swreg_gen.vh iob_pwm_swreg_def.vh
VHDR+=$(LIB_DIR)/hardware/include/iob_lib.vh $(LIB_DIR)/hardware/include/iob_s_if.vh $(LIB_DIR)/hardware/include/iob_gen_if.vh

#hardware include dirs
INCLUDE+=$(incdir). $(incdir)$(PWM_INC_DIR) $(incdir)$(LIB_DIR)/hardware/include

#sources
VSRC+=$(wildcard $(PWM_SRC_DIR)/*.v)

pwm-hw-clean:
	@rm -rf $(PWM_HW_DIR)/fpga/vivado/XCKU $(PWM_HW_DIR)/fpga/quartus/CYCLONEV-GT

.PHONY: pwm-hw-clean

endif
