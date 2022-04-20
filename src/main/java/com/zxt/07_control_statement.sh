#!/usr/bin/env bash

# for 循环
for loop in 1 2 3 4 5
do
    echo "The value is: ${loop}"
done

for str in This is a String
do
    echo "The value is: ${str}"
done


# while 循环
int=1
while ((${int} <= 5))
do
    echo ${int}
    let "int++"   # let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量
done


echo '按下 <CTRL-D> 退出'
echo -n '输入你最喜欢的网站名: '
while read FILM
do
    echo "是的！$FILM 是一个好网站"
done


# case ... esac
# case ... esac 为多选择语句，与其他语言中的 switch ... case 语句类似，是一种多分支选择结构，
# 每个 case 分支用右圆括号开始，用两个分号 ;; 表示 break，即执行结束，跳出整个 case ... esac 语句，esac（就是 case 反过来）作为结束标记。
# 可以用 case 语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令。

# case 取值后面必须为单词 in，每一模式必须以右括号结束。取值可以为变量或常数，匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;。
# 取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case ${aNum} in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac