include $(PWM_DIR)/hardware/hardware.mk

DEFINE+=$(defmacro)VCD

VSRC+=$(wildcard $(PWM_HW_DIR)/testbench/*.v)
