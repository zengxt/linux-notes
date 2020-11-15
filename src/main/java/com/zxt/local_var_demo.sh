#!/usr/bin/env bash

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