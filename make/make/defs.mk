SUB_DIR=$(patsubst %/, %, $(dir $(wildcard ./*/Makefile)))
SUB_LINK_OBJS=$(patsubst %/, %/built-in.o, $(dir $(wildcard ./*/Makefile)))

OBJ_LIST=$(SRC_LIST:.c=.o)
OBJ_FILE=$(addprefix ./, $(OBJ_LIST))
DEP_LIST=$(SRC_LIST:.c=.d)
DEP_FILE=$(addprefix ./, $(DEP_LIST))

DEP_LOOP=$(foreach i, $(SUB_DIR), $(MAKE) -C $(i) dep || exit 1;)
OBJ_LOOP=$(foreach i, $(SUB_DIR), $(MAKE) -C $(i) obj || exit 1;)
CLEAN_LOOP=$(foreach i, $(SUB_DIR), $(MAKE) -C $(i) clean;)
CLEAN_OBJ_LOOP=$(foreach i, $(SUB_DIR), $(MAKE) -C $(i) clean_o;)
CLEAN_DEP_LOOP=$(foreach i, $(SUB_DIR), $(MAKE) -C $(i) clean_d;)

