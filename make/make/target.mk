
include $(MAKE_RULES_PATH)/tools.mk

obj: $(OBJ_LIST)
	$(OBJ_LOOP)
	$(Q)$(LD) -r -o $(SUB_LINK_TARGET) $(OBJ_LIST) $(SUB_LINK_OBJS)

dep: $(DEP_LIST)
	$(DEP_LOOP)

$(OBJ_LIST): %.o : %.c %.d
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

$(DEP_LIST) : %.d : %.c
	$(Q)$(CC) $(CFLAGS) -MM $< > $@.tmp
	$(Q)sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.tmp > $@
	$(Q)$(RM) -f $@.tmp;

.PHONY: clean
clean: clean_o clean_d
	$(CLEAN_LOOP)
	$(Q)$(RM) -f $(SUB_LINK_TARGET)

.PHONY: clean_o
clean_o: clean_obj
	$(CLEAN_OBJ_LOOP)

.PHONY: clean_d
clean_d: clean_dep
	$(CLEAN_DEP_LOOP)

clean_obj:
ifneq (,$(word 1, $(OBJ_FILE)))
	$(Q)$(RM) -f $(OBJ_FILE)
endif

clean_dep:
ifneq (,$(word 1, $(DEP_FILE)))
	$(Q)$(RM) -f $(DEP_FILE)
endif

ifneq (,$(word 1, $(DEP_FILE)))
  sinclude $(DEP_FILE)
endif	
