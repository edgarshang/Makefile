

############make 2课 初始makefile结构
# all : test
# 	@echo "all"
# test:
# 	@echo "test"
###第一个makefile的编译案例
hello.out all : main.o func.o
	gcc -o hello.out main.o func.o
main.o : main.c
	gcc -o main.o main.c
func.o : func.c
	gcc -o func.o func.c
clean :
	rm -rf hello.out *.o

##########make 3课