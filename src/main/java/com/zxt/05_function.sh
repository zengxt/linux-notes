#!/usr/bin/env bash

# function 关键字可省略
test() {
    echo "test function"
}

test


function greeting {
    echo "hello $1"
}

greeting zhangsan
echo $?  # $? 显示最后命令的退出状态，0表示没有错误。如果函数中最后使用了 return，那么 $? 是函数的返回值


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

#while true
#do
#    nginx_daemon
#    sleep 5
#done


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
# calculate 20 * 30
calculate 200 / 30


# 获取系统的用户列表，并返回
function users() {
    user_list = `cat /etc/passwd | cut -d: -f1`
    echo ${user_list}
}


sh "D:\Java Notes\linux-notes\src\main\java\com\zxt\local_var_demo.sh"
