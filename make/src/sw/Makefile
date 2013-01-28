SRC_LIST=$(wildcard *.c)

include $(MAKE_RULES_PATH)/defs.mk
include $(MAKE_RULES_PATH)/target.mk

all:dep obj
	$(Q)$(LD) -r -o $(SUB_LINK_TARGET) $(OBJ_LIST)



