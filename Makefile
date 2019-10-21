

############make 2课 初始makefile结构
# all : test
# 	@echo "all"
# test:
# 	@echo "test"
###第一个makefile的编译案例
# hello.out all : main.o func.o
# 	gcc -o hello.out main.o func.o
# main.o : main.c
# 	gcc -o main.o -c main.c
# func.o : func.c
# 	gcc -o func.o -c func.c
# clean :
# 	@rm -rf hello.out *.o

##########make 3课伪目标的引入  2019.10.21
#思考，makefile中的目标究竟是什么？
#默认情况下，make人为目标对应着一个文件
#make比较目标文件和依赖文件的新旧关系，决定是否执行命令
#make以文件处理作为第一优先级

# 第三课第一小节
# hello.out all : main.o func.o
# 	gcc -o hello.out main.o func.o
# main.o : main.c
# 	gcc -o main.o -c main.c
# func.o : func.c
# 	gcc -o func.o -c func.c
# clean :
# 	@rm -rf hello.out *.o

#makefile中引入了.PHONY关键字声明一个伪目标
#伪目标不对应任何实际的文件
#不管伪目标的依赖是否更新，命令总是执行

#如果一个目标的依赖包含伪目标时，总是被执行
# .PHONY:clean rebuild all

# hello.out : main.o func.o
# 	gcc -o hello.out main.o func.o
# main.o : main.c
# 	gcc -o main.o -c main.c
# func.o : func.c
# 	gcc -o func.o -c func.c

# rebuild : clean all
# all : hello.out
# clean :
# 	rm -rf hello.out *.o
#伪目标的妙用，规则调用

#第二小节 绕开PHONY关键字定义伪目标
#如果一个规则没有命令或者没有依赖，并且它的目标不是一个存在的文件，在执行规则时，目标总会被认为是最新的

# clean : FORCE
# 	rm *.o hello.out
# FORCE :


.PHONY:clean rebuild all

hello.out : main.o func.o
	gcc -o hello.out main.o func.o
main.o : main.c
	gcc -o main.o -c main.c
func.o : func.c
	gcc -o func.o -c func.c

rebuild : clean all
all : hello.out
clean : FORCE
	rm -rf hello.out *.o
FORCE: 

