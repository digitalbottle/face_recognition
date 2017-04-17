shell学习笔记

Linux的Shell种类

Bourne Shell（/usr/bin/sh或/bin/sh）
Bourne Again Shell（/bin/bash）
C Shell（/usr/bin/csh）
K Shell（/usr/bin/ksh）
Shell for Root（/sbin/sh）

以下内容均基于bash.

#第一个shell脚本

#!/bin/bash
echo "hello, world!"

#赋予执行权限 最好加上【./文件名.sh】，表示就在当前目录找
chmod +x ./1.sh

#shell参数传递

#!/bin/bash
echo "Shell传递参数实例";
echo "文件名：$0";
echo "第一个参数为：$1";
echo "第二个参数为：$2";
echo "第三个参数为：$3";

#shell基本算符

#!/bin/bash
val=`expr 2+2`
echo "2+2=: $val"

#文件权限

#!/bin/bash
file="./1.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi

#echo命令

#!/bin/sh
read name 
echo "$name It is a test"

$ sh test.sh
OK                     #标准输入
OK It is a test        #输出

echo -e "OK! \n" # -e 开启转义
echo "It it a test"

#输出结果：
OK!

It it a test

#!/bin/sh
echo -e "OK! \c" # -e 开启转义 \c 不换行
echo "It is a test"
#输出结果：
OK! It is a test

#原样输出字符串，不进行转义或取变量(用单引号)
echo '$name\"'
#输出结果：
$name\"

#显示命令执行结果
echo `date`
#结果将显示当前日期
Thu Jul 24 10:08:46 CST 2014

#printf 命令
#printf 命令模仿 C 程序库（library）里的 printf() 程序
#标准所定义，因此使用printf的脚本比使用echo移植性好
#printf 使用引用文本或空格分隔的参数，外面可以在printf中使用格式化字符串，还可以制#定字符串的宽度、左右对齐方式等。默认printf不会像 echo 自动添加换行符，我们可以手动添加 \n。
#语法：printf  format-string  [arguments...]

#!/bin/bash
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 
#执行脚本，输出结果如下所示：
姓名     性别   体重kg
郭靖     男      66.12
杨过     男      48.65
郭芙     女      47.99

#shell test命令

cd /bin
if test -e ./notFile -o -e ./bash
then
    echo '有一个文件存在!'
else
    echo '两个文件都不存在'
fi

#shell流程控制
#和Java、PHP等语言不一样，sh的流程控制不可为空
#如果else分支没有语句执行，就不要写这个else

until condition
do
    command
done
条件可为任意测试条件，测试发生在until循环末尾，因此循环至少执行一次!

#函数
#可以带function fun() 定义，也可以直接fun() 定义,不带任何参数。
#参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return后跟数值n(0-255
#例子：

#!/bin/bash
demoFun(){
    echo "第一个 shell 函数"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"

#函数参数
#在Shell中，调用函数时可以向其传递参数。在函数体内部，通过 $n 的形式来获取参数的值，例如，$1表示第一个参数，$2表示第二个参数...
#带参数的函数示例：
#!/bin/bash
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73

#输出结果：
第一个参数为 1 !
第二个参数为 2 !
第十个参数为 10 !
第十个参数为 34 !
第十一个参数为 73 !
参数总数有 11 个!
作为一个字符串输出所有参数 1 2 3 4 5 6 7 8 9 34 73 !

#注意，$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数！

#shell 输入/输出重定向
#大多数 UNIX 系统命令从你的终端接受输入并将所产生的输出发送回​​到您的终端。一个命令通常从一个叫标准输入的地方读取输入，默认情况下，这恰好是你的终端。同样，一个命令通常将其输出写入到标准输出，默认情况下，这也是你的终端。
#重定向命令：
command > file	#将输出重定向到 file。
command < file	#将输入重定向到 file。
command >> file	#将输出以追加的方式重定向到 file。
n > file	#将文件描述符为 n 的文件重定向到 file。
n >> file	#将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m	#将输出文件 m 和 n 合并。
n <& m	#将输入文件 m 和 n 合并。
<< tag	#将开始标记 tag 和结束标记 tag 之间的内容作为输入。
需要注意的是文件描述符 0 通常是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。
输出重定向
重定向一般通过在命令间插入特定的符号来实现。特别的，这些符号的语法如下所示:
command1 > file1
上面这个命令执行command1然后将输出的内容存入file1。
注意任何file1内的已经存在的内容将被新内容替代。如果要将新内容添加在文件末尾，请使用>>操作符。
实例
执行下面的 who 命令，它将命令的完整的输出重定向在用户文件中(users):
$ who > users
执行后，并没有在终端输出信息，这是因为输出已被从默认的标准输出设备（终端）重定向到指定的文件。
你可以使用 cat 命令查看文件内容：
$ cat users
_mbsetupuser console  Oct 31 17:35 
tianqixin    console  Oct 31 17:35 
tianqixin    ttys000  Dec  1 11:33 
输出重定向会覆盖文件内容，请看下面的例子：
$ echo "菜鸟教程：www.runoob.com" > users
$ cat users
菜鸟教程：www.runoob.com
$
如果不希望文件内容被覆盖，可以使用 >> 追加到文件末尾，例如：
$ echo "菜鸟教程：www.runoob.com" >> users
$ cat users
菜鸟教程：www.runoob.com
菜鸟教程：www.runoob.com
$
输入重定向
和输出重定向一样，Unix 命令也可以从文件获取输入，语法为：
command1 < file1
这样，本来需要从键盘获取输入的命令会转移到文件读取内容。
注意：输出重定向是大于号(>)，输入重定向是小于号(<)。
实例
接着以上实例，我们需要统计 users 文件的行数,执行以下命令：
$ wc -l users
       2 users
也可以将输入重定向到 users 文件：
$  wc -l < users
       2 
注意：上面两个例子的结果不同：第一个例子，会输出文件名；第二个不会，因为它仅仅知道从标准输入读取内容。
command1 < infile > outfile
同时替换输入和输出，执行command1，从文件infile读取内容，然后将输出写入到outfile中。
重定向深入讲解
一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：
标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。
如果希望 stderr 重定向到 file，可以这样写：
$ command 2 > file
如果希望 stderr 追加到 file 文件末尾，可以这样写：
$ command 2 >> file
2 表示标准错误文件(stderr)。
如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写：
$ command > file 2>&1

或者

$ command >> file 2>&1
如果希望对 stdin 和 stdout 都重定向，可以这样写：
$ command < file1 >file2
command 命令将 stdin 重定向到 file1，将 stdout 重定向到 file2。
Here Document
Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。
它的基本的形式如下：
command << delimiter
    document
delimiter
它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。
注意：
结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
开始的delimiter前后的空格会被忽略掉。
实例
在命令行中通过 wc -l 命令计算 Here Document 的行数：
$ wc -l << EOF
    欢迎来到
    菜鸟教程
    www.runoob.com
EOF
3          # 输出结果为 3 行
$
我们也可以将 Here Document 用在脚本中，例如：
#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com

cat << EOF
欢迎来到
菜鸟教程
www.runoob.com
EOF
执行以上脚本，输出结果：
欢迎来到
菜鸟教程
www.runoob.com
/dev/null 文件
如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null：
$ command > /dev/null
/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。
如果希望屏蔽 stdout 和 stderr，可以这样写：
$ command > /dev/null 2>&1
注意：0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

Shell 文件包含
和其他语言一样，Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。
Shell 文件包含的语法格式如下：
. filename   # 注意点号(.)和文件名中间有一空格

或

source filename
实例
创建两个 shell 脚本文件。
test1.sh 代码如下：
#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com

url="http://www.baidu.com"
test2.sh 代码如下：
#!/bin/bash
#使用 . 号来引用test1.sh 文件
. ./test1.sh

# 或者使用以下包含文件代码
# source ./test1.sh

echo "baidu官网：$url"
接下来，我们为 test2.sh 添加可执行权限并执行：
$ chmod +x test2.sh 
$ ./test2.sh 
baidu官网：http://www.baidu.com

#注：被包含的文件 test1.sh 不需要可执行权限！