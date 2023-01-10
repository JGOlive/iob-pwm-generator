SHELL:=/bin/bash

TOP_MODULE=iob_pwm

#PATHS
REMOTE_ROOT_DIR ?=sandbox/iob-pwm
SIM_DIR ?=$(PWM_HW_DIR)/simulation/$(SIMULATOR)
FPGA_DIR ?=$(PWM_DIR)/hardware/fpga/$(FPGA_COMP)
DOC_DIR ?=

LIB_DIR ?=$(PWM_DIR)/submodules/LIB
PWM_HW_DIR:=$(PWM_DIR)/hardware

#MAKE SW ACCESSIBLE REGISTER
MKREGS:=$(shell find $(LIB_DIR) -name mkregs.py)

#DEFAULT FPGA FAMILY AND FAMILY LIST
FPGA_FAMILY ?=XCKU
FPGA_FAMILY_LIST ?=CYCLONEV-GT XCKU

#DEFAULT DOC AND DOC LIST
DOC ?=pb
DOC_LIST ?=pb ug

# default target
default: sim

# VERSION
VERSION ?=V0.1
$(TOP_MODULE)_version.txt:
	echo $(VERSION) > version.txt

#cpu accessible registers
iob_pwm_swreg_def.vh iob_pwm_swreg_gen.vh: $(PWM_DIR)/mkregs.conf
	$(MKREGS) iob_pwm $(PWM_DIR) HW

pwm-gen-clean:
	@rm -rf *# *~ version.txt

.PHONY: default pwm-gen-clean
