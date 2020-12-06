

在运行shell脚本时，添加 -x 可以显示脚本的执行过程，例如：sh -x hello.sh



# 一、shell中变量的高级使用

![image-20201108163048388](/picture/image-20201108163048388.png)

<br/>



# 二、函数的高级用法

&emsp;&emsp;Linux shell中的函数和大多数编程语言中的函数是一样的，将相似的任务或代码封装到函数中，供其他地方调用。

## 1、函数的定义格式

```shell
name() {
	command1
	command2
	....
}

# 有了function 关键字，函数名后面不需要加括号
function name {
	command1
	command2
	....
}
```

<br/>

## 2、如何调用函数

&emsp;&emsp;直接使用函数名调用，可以将其想象成shell中的一条命令，函数内部可以直接使用参数：$1、$2...$n。

&emsp;&emsp;调用函数 function_name $1 $2

示例：一个简单的守护进程的函数

```shell
# 一个简单的守护函数
function nginx_daemon() {
    # ps -ef | grep nginx | grep -v grep
    # $? 是上一个函数的返回值
    # echo $?

    ps -ef | grep nginx | grep -v grep &> /dev/null
    if [ $? == 0 ]; then
        echo "Nginx is running well"
    else
        systemctl start nginx
        echo "Nginx is down, start nginx..."
    fi
}

while true
do
    nginx_daemon
    sleep 5
done
```

<br/>

## 3、如何向函数传递参数

```shell
# 如何向函数中传递参数  --> 函数签名中无需指定参数，函数中只需要直接使用即可（$1, $2, .... 按顺序获取）
function calculate {
    case $2 in
        +)
            echo "`expr $1 + $3`"
            ;;  # ;; 是case的终结符
        -)
            echo "`expr $1 - $3`"
            ;;
        \*)
            # *代表匹配所有，所以这里需要转义
            echo "`expr $1 \* $3`"
            ;;
        /)
            echo "`expr $1 / $3`"
            ;;
        *)
            echo "unSupport other calculate!"
            ;;
    esac
}

# 调用函数的时候，直接将需要传递的参数跟在函数名后面用空格分隔
calculate 20 + 30
#calculate 20 * 30
calculate 200 / 30
```

**shell中的特殊变量**

| $0        | 当前脚本的文件名。                                           |
| --------- | ------------------------------------------------------------ |
| $n（n≥1） | 传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是 $1，第二个参数是 $2。 |
| $#        | 传递给脚本或函数的参数个数。                                 |
| $*        | 传递给脚本或函数的所有参数。                                 |
| $@        | 传递给脚本或函数的所有参数。当被双引号`" "`包含时，$@ 与 $* 稍有不同 |
| $?        | 上个命令的退出状态，或函数的返回值，一般情况下，大部分命令执行成功会返回 0，失败返回 1 |
| $$        | 当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。 |

<br/>

## 4、函数的返回值

&emsp;&emsp;1、return：使用return返回值，只能返回1-255的整数。函数使用return返回值，通常只是用来供其他地方调用获取状态，因此通常仅返回0或者1；0：表示成功，1：表示失败。

&emsp;&emsp;2、echo：使用echo可以返回任何字符串结果，通常用于返回数据，比如一个字符串值或者列表值。

```shell
# 获取系统的用户列表，并返回
function users() {
    user_list = `cat /etc/passwd | cut -d: -f1`
    echo $user_list
}
```

<br/>

## 5、函数的局部变量

&emsp;&emsp;shell函数中不做特殊声明，shell中的变量都是全局变量，在大型脚本程序中函数应该慎用全局变量。

&emsp;&emsp;定义局部变量，使用local关键字，该变量的作用域只存在于函数内部。如果函数内和函数外存在同名变量，则函数内部变量覆盖外部变量。

```shell
global_var_1="Hello World"

function local_var_test() {
    global_var_2=100
    local local_var_1=200
}

# 调用函数之前 var_global_2 是为空的
echo $global_var_1
echo $global_var_2
echo $local_var_1

local_var_test

# 调用函数之后 var_global_2 会变成一个全局变量, local_var_1 是 函数local_var_test的局部变量，在其他地方都无法使用
echo $global_var_1
echo $global_var_2
echo $local_var_1

function global_var_test() {
    echo $global_var_2
}
global_var_test
```

<br/>

## 6、库函数

&emsp;&emsp;可以定义一些库函数，供其他shell脚本调用执行。经验之谈：

&emsp;&emsp;1、库文件名的后缀名是任意的，但一般使用.lib；

&emsp;&emsp;2、库文件通常没有可执行选项；

&emsp;&emsp;3、库文件无需和脚本在同级目录，只需在脚本引用（直接写入库文件路径即可，或者 source filename）时指定；

&emsp;&emsp;4、第一行一般使用#!/bin/echo，输出警告信息，避免用户执行。

<br/>



# 三、shell编程中常用的工具

## 1、find命令

**语法格式：find [路径] [选项] [操作]**

**选项**

1、-name：根据文件名查找，例如，查找etc目录下后缀名为conf的文件：`find /etc -name '*.conf'`

-iname：根据文件名查找，忽略文件名大小写

2、-type：按文件类型查找

> &emsp;&emsp;f：文件，`find . -type f`
>
> &emsp;&emsp;d：目录，`find . -type d`
>
> &emsp;&emsp;c：字符设备文件，`find . -type c`
>
> &emsp;&emsp;b：块设备文件，`find . -type b`
>
> &emsp;&emsp;l：链接文件，`find . -type l`
>
> &emsp;&emsp;p：管道文件，`find . -type p`

3、-size -n | +n：按文件大小查找

>&emsp;&emsp;-n：大小小于n的文件，例如：查找/etc目录下小于1000字节的文件：`find /etc -size -1000c`
>
>&emsp;&emsp;+n：大小大于n的文件，例如：查找/etc目录下大于10M的文件：`find /etc -size +10M`
>
>&emsp;&emsp;n：大小等于n的文件（一般找不到，不建议使用）

4、-mtime -n | +n：根据文件更改时间查找（m：modify）

>&emsp;&emsp;-n：n天以内修改的文件，例如：查找/etc目录下5天之内修改且以conf结尾的文件：
>
>&emsp;&emsp;&emsp;&emsp;`find /etc -mtime -5 -name '*.conf'`
>
>&emsp;&emsp;+n：n天以前修改的文件，例如：查找/etc目录下10天之前修改且属主为root的文件：
>
>&emsp;&emsp;&emsp;&emsp;`find /etc -mtime +10 -user root`
>
>&emsp;&emsp;n：正好n天前修改的文件
>
>&emsp;&emsp;-mmin：用法和-mtime一样，time的时间单位为天数，min的时间单位为分钟

5、-user：根据文件属主查找 					-nouser：查找无有效属主的文件

6、-group：根据文件属组查找				  -nogroup：查找无有效属组的文件

7、-perm：根据文件权限查找，例如：`find . -perm 644`

8、指定查找的目录层级，需要直接跟在查找的目录后面

&emsp;&emsp;-mindepth n：从n级目录开始搜索，例如：在/etc目录下的3级子目录开始搜索：`find /etc -mindepth 3`

&emsp;&emsp;-maxdepth n：最多搜索到n级目录

&emsp;&emsp;&emsp;&emsp;例如：在/etc下搜索符合条件的文件，但最多搜索2级子目录：`find /etc -maxdepth 3 -name '*.conf'`

9、-prune：该选项可以排除某些查找目录，通常和-path一起使用，用于将特定的目录排除在搜素条件之外。

&emsp;&emsp;可以将`-path ./test -prune`理解成固定格式，就是排除某个路径，`-o`表示或的意思

&emsp;&emsp;例子1：查找当前目录下所有普通文件，但排除test目录：`find . -path ./test -prune -o -type f`

&emsp;&emsp;例子2：查找当前目录下所有的普通文件，但排除etc和opt目录：`find . -path ./etc -prune -o -path ./opt -prune -o -type f`

10、-newer file：查找比file文件新的文件：`find . -newer file `

<br/>

**操作**

1、-print：打印输出，默认操作

2、exec：对搜索到的文件执行特定的操作，格式为：`-exec 'command' {} \;`

&emsp;&emsp;例子1：搜索/etc下的文件（非目录），文件名以conf结尾，且大于10k，然后将其删除：

&emsp;&emsp;`find ./etc/ -type f -name '*.conf' -size +10k -exec rm -f {} \;`

&emsp;&emsp;例子2：将/var/log/目录下以log结尾的文件，且更改时间在7天以上的删除：

&emsp;&emsp;`find /var/log/ -name '*.log' -mtime +7 -exec rm -rf {} \;`

&emsp;&emsp;例子3：搜索条件和例子1一样，只是不删除，而是将其复制到/root/conf目录下：

&emsp;&emsp;`find ./etc/ -type f -name '*.conf' -size +10k -exec cp {} /root/conf/ \;`

3、-ok：功能和exec一样，只是每次操作都会给用户提示。

逻辑运算符：

> -a：与，多个条件，默认是-a
>
> -o：或
>
> -not | !：非

<br/>

## 2、find、locate、whereis和which总结及适用场景分析

&emsp;&emsp;locate命令：文件查找命令，所属软件包mlocate，不同于find命令是在整块磁盘中搜索，locate命令在数据库文件中查找。find是默认全部匹配，locate则是默认部分匹配。

&emsp;&emsp;updatedb命令：用户更新/var/lib/mlocate/mlocate.db，所使用的配置文件：/etc/updatedb.conf，该命令在后台由corn命令定期执行

&emsp;&emsp;whereis：查找某个命令的二进制程序文件、帮助文档、源代码文件

&emsp;&emsp;-b：只返回二进制文件，-m：只返回帮助文档文件，-s：只返回源代码文件

&emsp;&emsp;which：进查找二进制程序文件

&emsp;&emsp;-b：仅查找二进制文件

**各命令使用场景推荐：**

&emsp;&emsp;find：查找某一类文件，比如文件名部分一致，功能强大，速度慢

&emsp;&emsp;locate：只能查找单个文件，功能单一，速度快

&emsp;&emsp;wheris：查找程序的可执行文件、帮助文档等，不常用

&emsp;&emsp;which：只查找程序的可执行文件，常用于查找程序的绝对路径

<br/>



# 四、文本处理三剑客之grep

第一种形式：grep [option] [pattern] [file1, file2...]

第二种形式：command | grep [option] [pattern] 

grep参数，选项：

-v：不显示匹配行信息；

-i：搜索时忽略大小写；

-n：显示行号；

-r：递归搜索，例如在某个目录下查找某个内容：`grep -inr "hello" .`

-E：支持扩展正则表达式，等价与egrep。grep默认不支持扩展正则表达式，只支持基础正则表达式。

-F：不按正则表达式匹配，按照字符串字面意思匹配

-c：只输出匹配行的数量，不显示具体内容

-w：匹配整词

-x：匹配整行

-l：只列出匹配的文件名，不显示具体匹配行内容

<br/>



# 五、文本处理三剑客之sed

第一种形式：stdout | sed [option] "pattern command"

第二种形式：sed [option] "pattern command" file

## 1、sed的选项

-n 只打印模式匹配行

```shell
echo "sed 的 p 命令打印"
sed 'p' sed_file.txt  # 每行会输出两遍（原数据行 和 当前匹配到的行）
echo "################"

echo "-n 选项  只打印模式匹配行"
sed -n 'p' sed_file.txt
echo "################"

# 匹配模式固定写法 // 在两个斜杠之间，可以使用正则表达式，前面的两句只有命令p，没有匹配模式，会对文件中的每一行依次处理
sed -n '/python/p' sed_file.txt
echo "################"
```

-e：直接在命令行进行sed编辑，默认选项

```shell
echo "-e：直接在命令行进行sed编辑，默认选项"
sed -n -e '/python/p' -e '/PYTHON/p' sed_file.txt
echo "################"
```

-f：编辑动作保存在文件中，指定文件执行

```shell
echo "-f：编辑动作保存在文件中，指定文件执行"
sed -n -f edit.sed sed_file.txt
echo "################"
```

-r：支持扩展正则表达式

```shell
echo "-r：支持扩展正则表达式"
sed -n -r '/python|PYTHON/p' sed_file.txt
echo "################"
```

-i：直接修改文件内容

```shell
echo "-i：直接修改文件内容"
sed -n 's/love/like/g;p' sed_file.txt  # 这里文件没有被修改，只是将替换后的结果从命令行输出
sed -i 's/love/like/g' sed_file.txt # 实际修改了文件
echo "################"
```

<br/>

## 2、sed中的pattern详解

10command：匹配到第10行

10,20command：匹配从第10行开始，到第20行结束

10,+5command：匹配从第10行开始，到第16行结束

/pattern1/command：匹配到pattern1的行

/pattern1,/pattern2/command：匹配到pattern1的行开始，到匹配到pattern2的行结束

10,/pattern1/command：从第10行开始，到匹配到pattern1的行结束

/pattern1,10command：匹配到pattern1的行开始，到第10行结束









