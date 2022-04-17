#!/bin/bash

# 1、双引号可省略
echo "It is a test"
echo It is a test


# 2、\" 显示转义字符
echo "\"It is a test\""
echo \"It is a test\"


# 3、显示变量
read name
echo "Hello ${name}!"


# 4、显示换行
echo -e "OK! \n" # -e 开启转义
echo "It is a test"


# 5、不显示换行
echo -e "OK! \c" # -e 开启转义 \c 不换行
echo "It is a test"


# 6、重定向到文件
echo "It is a test" > myfile
echo "It is a test" > myfile
# > 覆写  >> 追加
echo "It is a test" >> myfile


# 7、用单引号，原样输出，不进行转义或取变量
echo '${name}\"'


# 8、显示命令执行结果
echo `date`  # 这里使用的是反引号 `, 而不是单引号 '。
