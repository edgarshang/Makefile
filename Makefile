
x := foo
y := $(x)b
x := new

a = foo
b = $(x)b
a = new

m := foo
n := $(m)b
m += $(n)

.PHONY : test

test:
	@echo "x => $(x)"
	@echo "y => $(y)"
	@echo "a => $(a)"
	@echo "b => $(b)"
	@echo "m => $(m)"
	@echo "n => $(n)"
