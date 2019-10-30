

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


# .PHONY:clean rebuild all

# hello.out : main.o func.o
# 	gcc -o hello.out main.o func.o
# main.o : main.c
# 	gcc -o main.o -c main.c
# func.o : func.c
# 	gcc -o func.o -c func.c

# rebuild : clean all
# all : hello.out
# clean : FORCE
# 	rm -rf hello.out *.o
# FORCE: 


#第四课，变量的不同的赋值方式
#支持变量的概念，并且只代表文本数据
#makefile的变量名规则
#可以包含数字下划线
#不能包含： # + “ ”等
#变量名大小写敏感

#第一小节
# TARGET := helloword.out
# CC := gcc

# .PHONY:clean rebuild all

# $(TARGET) : main.o func.o
# 	$(CC) -o $(TARGET) main.o func.o
# main.o : main.c
# 	$(CC) -o main.o -c main.c
# func.o : func.c
# 	$(CC) -o func.o -c func.c

# rebuild : clean all
# all : $(TARGET)
# clean : FORCE
# 	rm -rf $(TARGET) *.o
# FORCE: 

#第二节makefile中变量的赋值方式
#简单赋值（：=）
#递归赋值（=）
#条件赋值（？=）
#追加赋值（+=）   不同的赋值方式意义不同

#ex1
# x := foo
# y := $(x)b
# x := new



#ex2
# x = foo
# y = $(x)b
# x = new
# a = $(b)
# b = $(c)
# c = hello-makefile

#ex3
# x := foo
# y := $(x)b
# x ?= new

#ex4
# x := foo
# y := $(x)b
# x += new


#ex3
# .PHONY:test

# test:
# 	@echo "x = > $(x)"
# 	@echo "y = > $(y)"
# 	@echo "a = > $(a)"
# 	@echo "b = > $(b)"
# 	@echo "c = > $(c)"


#第五课，预定义变量的使用
#在makefile中存在一些预定义的变量
# -自动变量
# 	$@,当前规则中触发命令被执行的目标 
# 	$^,当前规则中所有的依赖
# 	$<，当前规则中第一个依赖
# 	注意，“$“ 对应makefile有特殊含义
# 	在bashshell有特殊含义，$@
# .PHONY : all first senond third
# all : first senond third
# 	@echo "\$$@ => $@"
# 	@echo "$$^ => $^"
# 	@echo "$$< => $<"
# first:
# senond:
# third:

##################################
# CC := gcc
# TARGET := hello-world.out

# $(TARGET) : main.o func.o
# 	$(CC) -o $@ $^
# main.o : main.c
# 	$(CC) -o $@ -c $^
# func.o : func.c
# 	$(CC) -o $@ -c $^


# .PHONY:clean rebuild all
# rebuild : clean all
# all : $(TARGET)
# clean : FORCE
# 	$(RM) -rf $(TARGET) *.o
# FORCE: 
##################################



#########第二节########################
# 特殊变量
#   $(MAKE)
##当前make解释器的文件名
# 	$(MAKECMDGOALS)
##命令行中指定的目标名（make的命令行参数）
# $(MAKEFILE_LIST)
##make所需处理的makefile文件列表
##当前makefile中的文件名总是位于列表的最后
##文件名之间以空格进行分割
# 	$(MAKE_VERSION)

# .PHONY : all out first second third
# all out : first second third
# 	@echo $(MAKE)
# 	@echo "$(MAKECMDGOALS)"
# 	@echo "$(MAKEFILE_LIST)"
# first:
# 	@echo "first"
# second:
# 	@echo "second"
# third:
# 	@echo "third"
# test:
# 	$(MAKE) first
# 	$(MAKE) second
# 	$(MAKE) third
#######################################

##############第三节####################
# .PHONY : all out test1 test2

# EDGARSHANG := shangzhiqiang
# all out : first second third
# 	@echo $(MAKE)
# 	@echo "$(MAKECMDGOALS)"
# 	@echo "$(MAKEFILE_LIST)"
# 	@echo $(MAKE_VERSION)
# 	@echo $(CURDIR)
# 	@echo "$(.VARIABLES)"
# test1:
# 	@echo $(RM)
# first:
# 	@echo "first"
# second:
# 	@echo "second"
# third:
# 	@echo "third"
# test:
# 	$(MAKE) first
# 	$(MAKE) second
# 	$(MAKE) third
#######################################


#############第六课、高级变量的替换#########################
#变量值的替换
#使用指定字符替换变量值中的后缀字符
#语法格式：$(var:a=b)或${var:a=b}
#替换表达式中不能有任何的空格
#make中支持使用${}对变量进行取值
# src := a.cc b.cc c.cc
# obj := $(src:cc=o)
# test:
# 	@echo "obj=> ${obj}"

#变量的模式替换
#使用%保留变量值中的指定字符，替换其他字符
#语法格式:$(var:a%b=x%y)或者${var:a%b=x%y}
#替换表达式中不能有任何空格
#make中支持使用${}对变量进行取值
# src := a1b.c a2b.c a3b.c
# obj := $(src:a%b.c=x%y.c)
# test1:
# 	@echo "obj=> $(obj)"
# #规则中的模式替换
# target：target-pattern：prereq-pattern：prereq
# 	command1
# 	...
#意义：通过target-pattern从targets中匹配字目标，再通过prereq-pattern从子目标生成依赖，进而构成完整的规则

#规则中的模式替换示列
# objs:= func.o main.o
# $(objs):%.o:%.c
# 	gcc -o $@ -c $^


# func.o:func.c
# 	gcc -o $@ -c $^
# main.o:main.c
# 	gcc -o $@ -c $^
###########################################

############第六课2小节###############################
# src1 := a.cc b.cc c.cc
# obj1 := $(src1:cc=o)
# test1:
# 	@echo "obj1=>$(obj1)"

# src2 := a1sd1b.c a22b.c a33b.c
# obj2 := $(src2:a%b.c=x%y)
# test2:
# 	@echo "obj2 => $(obj2)"
####################################################
# CC := g++
# TARGET := hello-makefile.out
# OBJS := func.o main.o const.o

# $(TARGET) : $(OBJS)
# 	$(CC) -o $@  $^
# $(OBJS) : %.o : %.c
# 	$(CC) -o $@ -c $^

# .PHONY:clean rebuild all
# rebuild : clean all
# all : $(TARGET)
# clean :
# 	$(RM) -rf $(TARGET) *.o
######################################################

#################第六课3节，变量值的嵌套引用#####################################
# hm:=hello makefile
# test:
# 	@echo "hm => $(hm)"
#运行make时，在命令行定义变量
#命令行变量默认覆盖makefile中的变量

#override关键字
#用于指定makefile中定义的变量不能被覆盖
#变量的定义和赋值都需要使用override关键字
# override hm:=hello makefile
# test:
# 	@echo "hm => $(hm)"

#define 关键字
#用于在makefile中定义多行变量
#多行变量的定义从变量名开始到endef结束
#可使用override关键字防止变量被覆盖
#define定义的变量等价于使用 = 定义的变量

# define foo
# I'm fool!
# endef

# override define cmd
# 	@echo "run cmd is ..."
# 	@ls
# endef
#############################第六课4节，变量值的嵌套引用#############################################
# hm:=hello makefile
# override var:= override-test
# define foo
# I'm senseMaker
# endef

# override define cmd
# 	@echo "run cmd is..."
# 	@ls
# endef
# test:
# 	@echo "hm => $(hm)"
# 	@echo "var=> $(var)"
# 	@echo "foo=> $(foo)"
# 	$(cmd)

######第七课、全局变量、文件变量、局部变量
############################第七课第一节，##########################################################
##环境变量
#makefile中能够直接使用环境变量的值
#定义了同名变量，环境变量将被覆盖
#运行make时指定-e选项，优先使用环境变量

#为啥要在makefile中使用环境变量
#变量在不同makefile之间的传递方式
##直接在外部定义环境变量进行传递
##使用export定义变量进行传递（定义临时环境变量）
##定义make命令行变量进行传递（推荐）
# JAVA_HOME := java home
# JAVA_VERSION := java -version
# var := D.T.Software
# MAKE := make
# test:
# 	@echo "JAVA_HOME => $(JAVA_HOME)"
# 	@echo "JAVA_VERSION => $(JAVA_VERSION)"
# 	@$(MAKE) -f makefile2
# 	@echo "hello => $(hello)"
##########################第七课第三节#######################################################
##目标变量
###作用域只在指定目标及连带规则中
#.target : name <assignment> value
#.target : override name <assignment> value
### var := D.T.Software
### test : var := test-var  // var的作用域只是在test中
### test:
#      @echo "test:"
#      @echo "var => $(var)"

# var := D.T.Software
# test : var := test_var

# %e : override new := test-new #不希望在make中改变new的值

# test:
# 	@echo "test:"
# 	@echo "new => $(var)"
# rule:
# 	@echo "rule:"
# 	@echo "new => $(new)"

#####################################
# var := D.T.Software
# test: var:= test-var

# %e:new := helloword

# test:another
# 	@echo "test:"
# 	@echo "var => $(var)"
# another:rule
# 	@echo "another:"
# 	@echo "var => $(var)"
# 	@echo "new => $(new)"
# rule:
# 	@echo "rule:"
# 	@echo "new => $(new)"


###################第八课、条件判断语句#################################
####第一节
###makefile中支持条件判断语句
#可以根据条件的值来决定make的执行
#可以比较两个不同变量或者变量和常量值
# // arg1和arg2之间不能有空格
#  ifxxx(arg1,arg2)
#  # for ture
#  else
#  #for false
#  endif
#
###注意事项
#条件判断语句只能控制make实际执行的语句，但是，不能控制规则中命令的执行过程
#
#常用形式
##ifxxx (arg1,arg2)
#其它合法形式
#ifxxx "arg1" "arg2"
#ifxxx "arg1" "arg2"
#ifxxx "arg1" "arg2"
#ifxxx "arg1" "arg2"

#
#ifeq 判断是否相等
#ifneq 判断是否不相等
#ifdef 判断变量是否有值
#ifndef 判断变量是否没有值
#



# .PHONY:test

# var1 := A
# var2 := $(var1)
# var3 := 

# test:
#     ifeq ($(var1), $(var3))
# 		@echo "var1 == var2"
#     else
# 		@echo "var1 != var2"
#     endif

#     ifneq ($(var2),)
# 		@echo "var2 is NOT empty"
#     else
# 		@echo "var2 is empty"
#     endif

#     ifdef var2
# 		@echo "var2 is NOT empty"
#     else 
# 		@echo "var2 is empty"
#     endif

#     ifndef var3
# 		@echo "var3 is empty"
#     else
# 		@echo "var3 is not empty"
#     endif
#####第二节
#一些工程经验
##条件判断语句之前可以有空格，但是不能有tab键
##在条件语句中不要使用自动变量（（$@， $^, $<））
##一条完整的条件语句必须位于同一个makefile中
##条件判断类似C语言中的宏，预处理阶段有效，执行阶段无效
##make在加载makefile时，
####首先计算表达式的值（赋值方式不同，计算方式不同）
####根据判断语句的表达式决定执行的内容

var1 = 
var2 = $(var1)

test:
    ifdef var1
	@echo "var1 is defined"
    else
	@echo "hello"
    endif

    ifdef var2
	@echo "var2 is defined"
    endif

test1:










# result:= abc

# .PHONY: all

# ifeq (1,1)
# result=$(shell ls *.c)
# $(warning $(result))
# endif



