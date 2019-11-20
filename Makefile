

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

# var1 = 
# var2 = $(var1)

# test:
#     ifdef var1
# 	@echo "var1 is defined"
#     else
# 	@echo "hello"
#     endif

#     ifdef var2
# 	@echo "var2 is defined"
#     endif

# test1:
#########################第九课 函数定义及使用
###########第一节
#提供了一系列的函数供makefile调用
#支持自定义函数
#函数定义
# define func1
# 	@echo "my name is $(0)"
# endef

# define func2
# 	@echo "My name is $(0)"
# 	@echo "Param=>$(1)"
# 	@echo "Param=>$(2)"
# 	@echo "Param=>$(3)"
# endef

# var := $(call func1)
# var1 := $(func1)

# #函数调用
# test:
# 	@echo "var1 => $(var1)"
# 	@echo "var => $(var)"
# 	$(call func1)
# 	$(call func2, edgarshang, love, you)

#自定义函数是一个多行变量
#自定义函数是一个过程调用，没有任何的返回值
#自定义函数用于定义函数集合，并应用于规则中
####第二节
###make解释器中的预定义函数
#make的函数提供了处理文件名，变量和命令的参数
#可以在需要的地方调用函数来处理指定的参数
#函数的在调用的地方被替换为处理结果
#预定义函数有返回值
#预定义函数的调用
#var:=$(func_name arg1, arg2, ....)
# var:=$(abspath ./)
# test:
# 	@echo "var = $(var)"
#为什么自定义和内置函数差异这么大
#make函数中不支持真正意义上的自定义函数
#自定义函数本质上是多行变量
#自定义函数是call函数的实参，并且在call中被执行
##函数剖析
#

# .PHONY:test
# define func1
# 	@echo "my name is $(0)"
# endef
# define func2
# 	@echo "my name is $(0)"
# endef

# var1 := $(call func1)
# var2 := $(call func2)
# var3 := $(abspath ./)
# var4 := $(abspath test.cpp)
# var5 := $()
# #函数调用
# test:
# 	$(func1)
# 	$(call func1)
# 	@echo "var1 => $(var1)"
# 	@echo "var2 => $(var2)"
# 	@echo "var3 => $(var3)"
# 	@echo "var4 => $(var4)"


#####第十课，变量与函数的综合示列
####第一节2019.11.04
###自动生成target文件夹存放可执行文件
###自动生成objs文件夹存放编译生成的目标文件（*.o）
###支持调试版本的编译选项
###考虑代码的扩展性

##工具原料
#$(wildcard _parttern)
##获取当前工作目录中满足——parttern的文件或者目录列表
#$(addprefix _prefix, _names)
##给名字列表_names中每一个名字增加前缀_prefix
##关键技巧
##自动获取当前目录下的源文件列表（函数调用）
#SRC := $(wildcard *.c)
##根据源文件列表生成目标文件列表（变量的值替换）
#OBJS := $(SRC:.c=.o)
##对每一个目标文件列表路径前缀（函数调用）
#OBJS := $(addprefix path/, $(OBJS))

##规则中的模式替换（目录结构）
#工作中目录存在func.c和main.c
#%.o:%c
##gcc -o $@ -c $^
#func.o : func.c
##gcc -o $@ -c $^
#main.o : main.c
##gcc -o $@ -c $^ 


####第二节2019.11.05
# CC := gcc
# MKDIR := mkdir
# RM := rm -rf

# DIR_OBJS := objs
# DIR_TARGET := target

# DIRS := $(DIR_OBJS) $(DIR_TARGET)
# #TARGET := $(DIR_TARGET)/hello-makefile.out
# TARGET := $(addprefix $(DIR_TARGET)/, helloword.out)
# # main.c const.c func.c
# SRCS := $(wildcard *.c)
# # main.o const.o func.o
# OBJS := $(SRCS:.c=.o)
# #objs/main.o objs/const.o objs/func.o
# OBJS := $(addprefix $(DIR_OBJS)/, $(OBJS))

# .PHONY : rebuild clean all

# $(TARGET) : $(DIRS) $(OBJS)
# 	$(CC) -o $@ $(OBJS)
# 	@echo "Target file ==> $@"
# $(DIRS):
# 	$(MKDIR) $@
# #$(OBJS):$(DIR_OBJS)/%.o : %.c
# $(DIR_OBJS)/%.o : %.c
# 	$(CC) -o $@ -c $^
# rebuild: clean all

# all:$(TARGET)

# clean:
# 	$(RM) $(DIR_OBJS) $(DIR_TARGET)



##第三节

# CC := gcc
# MKDIR := mkdir
# RM := rm -rf

# DIR_OBJS := objs
# DIR_TARGET := target

# DIRS := $(DIR_OBJS) $(DIR_TARGET)
# #TARGET := $(DIR_TARGET)/hello-makefile.out
# TARGET := $(addprefix $(DIR_TARGET)/, helloword.out)
# # main.c const.c func.c
# SRCS := $(wildcard *.c)
# # main.o const.o func.o
# OBJS := $(SRCS:.c=.o)
# #objs/main.o objs/const.o objs/func.o
# OBJS := $(addprefix $(DIR_OBJS)/, $(OBJS))

# .PHONY : rebuild clean all

# $(TARGET) : $(DIRS) $(OBJS)
# 	$(CC) -o $@ $(OBJS)
# 	@echo "Target file ==> $@"
# $(DIRS):
# 	$(MKDIR) $@
# #$(OBJS):$(DIR_OBJS)/%.o : %.c
# $(DIR_OBJS)/%.o : %.c func.h
#     ifeq ($(DEBUG),true)
# 		$(CC) -o $@ -g -c $<
#     else
# 		$(CC) -o $@ -c $<
#     endif
# rebuild: clean all

# all:$(TARGET)

# clean:
# 	$(RM) $(DIR_OBJS) $(DIR_TARGET)

###第十一课
##第一节
##自动生成依赖关系
##值得思考的问题
##目标文件时候只依赖于源文件
##编译器如何编译源文件和头文件
##预处理器将头问家里的代码直接插入源文件
##编译器只通过预处理后的源文件产生目标文件
##因此，规则中以源文件为依赖，命令可能无法执行

# OBJS:=func.o main.o
# hello.out : $(OBJS)
# 	@gcc -o $@ $^
# 	@echo "Target File ==> $@"
# $(OBJS) : %o : %c func.h
# 	@gcc -o $@ -c $<

###第二节
##通过命令自动生成对头文件的依赖
#将生成的依赖自动包含进makefile中
#当头文件改动后，自动确认
#预备工作
#sed命令
#gcc -MM(gcc -M)编译器依赖选项
###sed是一个流编辑器，用于流文本的修改
###sed可用于流文本的中的字符串替换
###sed的字符串替换方式为：sed 's:src:des:g'

###echo "test=>abc+abc=abc" | sed 's:abc:xyz:g'
###test=>xyz+xyz=xyz
###sed的正则表达式支持
####在sed中可以用正则表达式匹配替换目标
####并且可以使用匹配的目标生成替换结果
####sed 's,\(.*\)\.o[ :]*, objs/\1.o :,g'
###         正则表达式匹配目标  将匹配结果进行替换

##gcc关键编译选项
##-生成依赖关系
###获取目标的完整依赖关系
###gcc -M test.c
###获取目标的部分依赖关系
###gcc -MM test.c

###第三节 11.3
# OBJS:=func.o main.o
# hello.out : $(OBJS)
# 	@gcc -o $@ $^
# 	@echo "Target File ==> $@"
# $(OBJS) : %o : %c func.h
# 	@gcc -o $@ -c $<



###12.1
#makefile中的include关键字
#类似C中的include
#将其他文件中的内容原封不动的搬到当前文件中
#语法，include filename
##include foo.make *.mk $(var)
##make对include关键字的处理方式
#在当前目录搜索或指定目录搜索目标文件
###搜索成功：将文件内容搬入当前makefile中
###搜索失败：产生警告
##以文件名作为目标查找并执行对应规则
##当文件名对应的规则不存在时，最终产生错误
# .PHONY : all
# include test.txt

# all:
# 	@echo "this is $@"
# test.txt:
# 	@echo "test.txt"
# 	@touch test.txt

###12.2
##makefile中执行机制
##规则中的每个命令默认是在一个新的进程中执行（shell）
##可以通过接续符（；）将多个命令组合成一个命令
##组合的命令依次在同一个进程中被执行
##set -e指定发生错误后立即退出执行

# .PHONY : all


# all:
# 	set -e;   \
# 	mkdir test;\
# 	cd test;\
# 	mkdir subtest

###12.3
##解决方案的初步思路
###通过gcc -MM 和 sed 得到.dep依赖文件（目标的部分依赖）
######技术点：规则中命令的连续执行
###通过include指令包含所有的.dep依赖文件
######技术点：当.dep依赖文件不存在时，使用规则自动生成
# .PHONY : all clean
# MKDIR := mkdir
# RM := rm -rf
# CC := gcc

# SRCS := $(wildcard *.c)
# DEPS := $(SRCS:.c=.dep)

# -include $(DEPS)

# all:
# 	@echo "all"
# %.dep : %.c
# 	@echo "Creating $@..."
# 	set -e;\
# 	$(CC) -MM -E $^ | sed 's,\(.*\)\.o[ :]*, objs/\1.o :,g' > $@
# clean:
# 	$(RM) $(DEPS)


####13.1自动生成依赖关系

###解决思路，
#####当include发现.dep文件不存在时：
######1、通过规则和命令创建deps文件夹
######2、将所有.dep文件创建到deps文件夹
######3、.dep文件中记录目标文件的依赖关系
# .PHONY : all clean
# MKDIR := mkdir
# RM := rm -rf
# CC := gcc

# DIR_DEPS := deps

# SRCS := $(wildcard *.c)
# DEPS := $(SRCS:.c=.dep)
# DEPS := $(addprefix $(DIR_DEPS)/,$(DEPS))

# ifeq ("$(MAKECMDGOALS)", "all")
# include $(DEPS)
# endif

# ifeq ("$(MAKECMDGOALS)", "")
# include $(DEPS)
# endif

# all:
# 	@echo "all"

# $(DIR_DEPS):
# 	$(MKDIR) $@
# ifeq ("$(wildcard $(DIR_DEPS))", "")
# $(DIR_DEPS)/%.dep : $(DIR_DEPS) %.c
# else
# $(DIR_DEPS)/%.dep : %.c
# endif
# 	@echo "Creating $@..."
# 	set -e;\
# 	$(CC) -MM -E $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*, objs/\1.o :,g' > $@
# clean:
# 	-$(RM) $(DIR_DEPS)


###13.2为啥.dep文件会被创建多次
#####deps文件夹的时间属性会因为依赖文件创建而发生改变
#####make发现deps文件夹比对应的目标更新
#####出发相应规则的重新解释


# .PHONY : all clean
# MKDIR := mkdir
# RM := rm -rf
# CC := gcc

# DIR_DEPS := deps

# SRCS := $(wildcard *.c)
# DEPS := $(SRCS:.c=.dep)
# DEPS := $(addprefix $(DIR_DEPS)/,$(DEPS))

# ifeq ("$(MAKECMDGOALS)", "all")
# include $(DEPS)
# endif

# ifeq ("$(MAKECMDGOALS)", "")
# include $(DEPS)
# endif

# all:
# 	@echo "all"

# $(DIR_DEPS):
# 	$(MKDIR) $@
# ifeq ("$(wildcard $(DIR_DEPS))", "")
# $(DIR_DEPS)/%.dep : $(DIR_DEPS) %.c
# else
# $(DIR_DEPS)/%.dep : %.c
# endif
# 	@echo "Creating $@..."
# 	set -e;\
# 	$(CC) -MM -E $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*, objs/\1.o :,g' > $@
# clean:
# 	-$(RM) $(DIR_DEPS)


#####13.3
###include的暗黑操作
###一:使用减号(-)不当关闭了include发出的警告,同事关闭了错误,当错误发生时 make将忽略这些错误
# .PHONY : all
# -include test.txt

# all:
# 	@echo "this is all"
##编写调试makefile时候,不要加上减号

###二:
###如果include出发规则创建了文件,之后还会发生什么?
# .PHONY:all
# -include test.txt
# all:
# 	@echo "this is all"
# test.txt:
# 	@echo "Creating $@"
# 	@echo "other:;@echo "this is other"" > test.txt

#三
###如果include包含的文件存在,之后还会发生什么?
# .PHONY : all
# include test.txt
# all:
# 	@echo "this is all"
# test.txt:b.txt
# 	@echo "Creating is $@"

##当一个include文件进来后,会检查规则有没有,如果有,则会继续检查时间戳,如果依赖更新,则要执行这条规则


####13.4
# .PHONY : all
# include test.txt
# all:
# 	@echo "$@: $^"
# test.txt:b.txt
# 	@echo "Creating is $@"
# 	@echo "all:c.txt" > test.txt

# include关键字总结
# 当目标文件不存在时,
# 	以文件名查找规则,并执行
# 当目标文件不存在时,且查找到的规则中创建了目标文件
# 	将创建的成功的目标文件包含进当前makefile

# 如果目标文件存在
# 	将创建的成功的目标文件包含进当前makefile
# 	以目标文件名查找是否有相应规则
# 		yes:比较规则的依赖关系,决定是否执行规则的命令
# 		no:null,无操作

# 当目标文件存在,并且文件名对应的规则也被执行
# 	规则中的命令更新了目标文件
# 		make重新包含目标文件,替换之前包含的内容
# 	目标文件未被更新
# 		null没有操作

####14自动生成依赖关系
##

# .PHONY : all clean rebuild
# MKDIR := mkdir
# RM := rm -rf
# CC := gcc

# DIR_DEPS := deps
# DIR_EXES := exes
# DIR_OBJS := objs

# DIRS := $(DIR_DEPS) $(DIR_EXES) $(DIR_OBJS)

# EXE := app.out
# EXE := $(addprefix $(DIR_EXES)/, $(EXE))

# SRCS := $(wildcard *.c)
# OBJS := $(SRCS:.c=.o)
# OBJS := $(addprefix $(DIR_OBJS)/, $(OBJS))
# DEPS := $(SRCS:.c=.dep)
# DEPS := $(addprefix $(DIR_DEPS)/, $(DEPS))

# all : $(DIR_OBJS) $(DIR_EXES) $(EXE)

# ifeq ("$(MAKECMDGOALS)", "all")
# include $(DEPS)
# endif

# ifeq ("$(MAKECMDGOALS)", "")
# include $(DEPS)
# endif

# $(EXE) : $(OBJS)
# 	$(CC) -o $@ $^
# 	@echo "Success! Target => $(EXE)"	

# $(DIR_OBJS)/%.o : %.c
# 	@echo "----> $<"
# 	$(CC) -o $@ -c $(filter %.c, $^)

# $(DIRS):
# 	$(MKDIR) $@


# ifeq ("$(wildcard $(DIR_DEPS))", "")
# $(DIR_DEPS)/%.dep : $(DIR_DEPS) %.c
# else
# $(DIR_DEPS)/%.dep : %.c
# endif
# 	@echo "Creating $@..."
# 	@set -e;\
# 	$(CC) -MM -E $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*, objs/\1.o $@ : ,g' > $@
# clean:
# 	$(RM) $(DIRS)
# rebuild:
# 	$(MAKE) clean
# 	$(MAKE) all

##小节
#makefile中可以将目标的依赖拆分写到不同的地方
#include关键字能够出发相应的规则的执行
#如果规则的执行导致依赖更新,可能导致再次解释执行相应规则
#依赖文件也需要依赖于源文件得到正确的编译决策
#自动生成文件间的依赖关系能够提高makefile的移植性

##############--------------------------------------------------------
###15 课
#如果一个目标的命令拆分的写到不同地方,会发生什么?
# .PHONY: all
# all:
# 	@echo "command-1"
# VAR := test
# all:
# 	@echo "all:$(VAR)"
##############--------------------------------------------------------
##makefile中出现同名目标时,
###依赖:
#####所有依赖将合并在一起,称为目标的最终依赖
###命令:
#####当多处出现同一目标命令时,make发出警告
#####所有之前定义的命令被最后定义的命令取代

###注意事项
###-当使用include关键字包含其他文件时,需要确保被包含文件中的同名目标只有依赖,没有命令,否则,同名目标的命令将被覆盖
# .PHONY: all

# VAR := test
# all:
# 	@echo "all:$(VAR)"

# include 1.mk
##############--------------------------------------------------------
####15.2
###什么是make中的隐式规则?
####----make提供了一些常用的,例行的规则实现
###----当相应目标的规则未提供时,make尝试使用隐式规则

##############--------------------------------------------------------
#####? 下面的程序能否正常执行,为什么?
SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)

app.out:$(OBJS)
	$(CC) -o $@ $^
	$(RM) $^
	@echo "Target ==> $@"

#####答案是:make中有隐式规则,可以让
###CC是C语言编译器,第一个C是C语言,第二个C是complair



##############--------------------------------------------------------
###学习心得,include时候,如果包含的文件在,则直接复制过来,如果没有,看没有以他作为目标的依赖

##小技巧：拆分目标的依赖
##将目标的完整依赖拆分为多个部分依赖
############################
# .PHONY:a b c
# test: a b c
# 	@echo "$^"

#等价于

# .PHONY:a b c

# test: a b
# test: b c
# test:
# 	@echo "$^"
##########################






