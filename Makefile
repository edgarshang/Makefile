.PHONY:all out first second third test test1 test2

all out:
	@echo "$(MAKE)"
	@echo "$(MAKECMDGOALS)"
	@echo "$(MAKEFILE_LIST)"

first:
	@echo "first"
second:
	@echo "second"
third:
	@echo "third"


test:
	@$(MAKE) first
	@$(MAKE) second
	@$(MAKE) third
test1:
	@echo "$(MAKE_VERSION)"
	@echo "$(CURDIR)"
	@echo "$(.VARIABLES)"

test2:
	@echo "$(RM)"
test3:
	$(RM) hello_world
