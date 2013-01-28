ifdef V
  ifeq ("$(origin V)", "command line")
    KBUILD_VERBOSE = $(V)
  endif
endif
ifndef KBUILD_VERBOSE
  KBUILD_VERBOSE = 0
endif

ifeq ($(KBUILD_VERBOSE),1)
  Q =
else
  Q = @
endif


PRJ_PATH = $(shell pwd)
MAKE_RULES_PATH = $(PRJ_PATH)/make
SRC_PATH = $(PRJ_PATH)/src
INCLUDE_PATH = $(PRJ_PATH)/include

INC_DIR := $(shell find $(INCLUDE_PATH) -type d -print)

SUB_LINK_TARGET = built-in.o

export PRJ_PATH
export MAKE_RULES_PATH
export INC_DIR
export SUB_LINK_TARGET
export Q

include $(MAKE_RULES_PATH)/tools.mk

TARGET=test

SUB_DIR = $(patsubst %/, %, $(dir $(if $(wildcard $(SRC_PATH)/Makefile), $(SRC_PATH)/Makefile)))
SUB_DIR += $(patsubst %/, %, $(dir $(wildcard $(SRC_PATH)/*/Makefile)))

SUB_LINK_OBJS = $(patsubst %/, %/$(SUB_LINK_TARGET), $(dir $(if $(wildcard $(SRC_PATH)/Makefile), $(SRC_PATH)/Makefile)))

# if src top have not Makefile, it means the entry point is in another dir
# so need the sub dir link objs
# if src top have Makefile, it means the entry point is at src top dir
# the all sub dir will link to the src top dir link objs
ifeq ($(SUB_LINK_OBJS), )
SUB_LINK_OBJS += $(patsubst %/, %/$(SUB_LINK_TARGET), $(dir $(wildcard $(SRC_PATH)/*/Makefile)))
endif

all: subdirs
	$(Q)echo $(SUB_LINK_OBJS)
	$(Q)$(CC) -o $(TARGET) $(SUB_LINK_OBJS)

subdirs: $(patsubst %, _dir_%, $(SUB_DIR))

$(patsubst %, _dir_%, $(SUB_DIR)) :
	$(Q)$(MAKE) -C $(patsubst _dir_%, %, $@)


.PHONY: clean
clean: subdirs_clean
	$(Q)$(RM) -f $(TARGET)

subdirs_clean: $(patsubst %, _dir_clean_%, $(SUB_DIR))

$(patsubst %, _dir_clean_%, $(SUB_DIR)) :
	$(Q)$(MAKE) -C $(patsubst _dir_clean_%, %, $@) clean

