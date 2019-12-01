# An Introduction to Makefiles

我们需要一个`makefile`文件来告诉`make` 去做什么。通常情况下，这个makefile文件告诉make如何去编译（compile）和链接（link）一个程序。

makefile关系到了整个工程的编译规则。一个工程中的源文件不计数，其按类型、功能、模块分别放在若干个目录中，makefile定义了一系列的规则来指定，哪些文件需要先编译，哪些文件需要后编译，哪些文件需要重新编译，甚至于进行更复杂的功能操作，因为makefile就像一个Shell脚本一样，其中也可以执行操作系统的命令。

makefile带来的好处就是——“自动化编译”，一旦写好，只需要一个make命令，整个工程完全自动编译，极大的提高了软件开发的效率。make是一个命令工具，是一个解释makefile中指令的命令工具.

把源文件编译成中间代码文件，在Windows下也就是 .obj 文件，UNIX下是 .o 文件，即 Object File，这个动作叫做编译（compile）。

然后再把大量的Object File合成执行文件，这个动作叫作链接（link）。

编译时，编译器需要的是语法的正确，函数与变量的声明的正确。

链接时，主要是链接函数和全局变量。

源文件首先会生成中间目标文件，再由中间目标文件生成执行文件。在编译时，编译器只检测程序语法，和函数、变量是否被声明。如果函数未被声明，编译器会给出一个警告，但可以生成Object File。而在链接程序时，链接器会在所有的Object File中找寻函数的实现，如果找不到，那到就会报链接错误码（Linker Error），

## What a Rule Looks Like

一个简单的makefile由具有以下组成“规则”组成：
```
target … : prerequisites …
        recipe
        …
        …
```

+ target：通常是由程序生成的文件的名称，也可以是要执行的操作的名称。
+ prerequisites：用作输入以创建目标文件，通常取决于多个文件。
+ recipe：一个make执行动作，可能在同一行或每行都具有多个命令。
    + 每行的开头添加一个制表符

## A Simple Makefile

