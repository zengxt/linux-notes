#!/usr/bin/env bash

# Bash Shell 只支持一维数组（不支持多维数组），初始化时不需要定义数组大小，下表从 0 开始
# Shell 数组用括号表示，元素用"空格"符号分割开，语法格式如下：
# array_name=(value1 value2 ... valuen)

array_name=(value1 value2 value4 valuen)
echo "第一个元素为: ${array_name[0]}"
echo "第二个元素为: ${array_name[1]}"
echo "第三个元素为: ${array_name[2]}"
echo "第四个元素为: ${array_name[3]}"


# 使用@ 或 * 可以获取数组中的所有元素，例如：
echo "数组的元素为: ${array_name[*]}"
echo "数组的元素为: ${array_name[@]}"


# 获取数组长度的方法与获取字符串长度的方法相同，例如：
echo "数组元素个数为: ${#array_name[*]}"
echo "数组元素个数为: ${#array_name[@]}"
