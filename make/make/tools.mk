CROSS_COMPLIE ?=

AS              = $(CROSS_COMPILE)as
CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
CPP             = $(CC) -E
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
STRIP           = $(CROSS_COMPILE)strip
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump

ifneq ($(findstring mips, $(CROSS_COMPILE)), )
BUILD_FLAG	= -Os -fomit-frame-pointer -pipe
else
BUILD_FLAG	= -O2 -pipe
endif

INC_FLAG	= $(foreach f,$(INC_DIR),$(addprefix -I, $(f)))

# if have some depend lib, add to LIBS, eg: -lpthread
# can redefine this in Makefile which is in sub dir
LIBS		?=

LDFLAGS		?=

CFLAGS		+= $(INC_FLAG) $(BUILD_FLAG)

