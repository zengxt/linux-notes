#!/bin/bash

# printf  format-string  [arguments...]
# format-string: 为格式控制字符串
# arguments: 为参数列表。
# printf 使用引用文本或空格分隔的参数，外面可以在 printf 中使用格式化字符串，还可以制定字符串的宽度、左右对齐方式等。
# 默认的 printf 不会像 echo 自动添加换行符，我们可以手动添加 \n。

logging () {
    printf "%-10s %-8s %s\n" "[`date '+%Y-%m-%d %H:%M:%S:%3N'`]" "[$1]:" "$2"
}

logging 'INFO' 'This is a info log'
logging "ERROR" 'This is a error log'


# %s %c %d %f 都是格式替代符，％s 输出一个字符串，％d 整型输出，％c 输出一个字符，％f 输出实数，以小数形式输出。
# %-10s 指一个宽度为 10 个字符（- 表示左对齐，没有则表示右对齐），任何字符都会被显示在 10 个字符宽的字符内，
# 如果不足则自动以空格填充，超过也会将内容全部显示出来。
# %-4.2f 指格式化为小数，其中 .2 指保留2位小数。
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876


# format-string为双引号
printf "%d %s\n" 1 "abc"

# 单引号与双引号效果一样
printf '%d %s\n' 1 "abc"

# 没有引号也可以输出
printf %s abcdef

# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def

printf "%s\n" abc def

printf "%s %s %s\n" a b c d e f g h i j

# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n"

# 转义字符
printf "a string, no processing:<%s>\n" "A\nB"
printf "a string, no processing:<%b>\n" "A\nB"
printf "www.runoob.com \a"
