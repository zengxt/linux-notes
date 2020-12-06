#!/usr/bin/env bash

echo "sed 的 p 命令打印"
sed 'p' sed_file.txt  # 每行会输出两遍（原数据行 和 当前匹配到的行）
echo "################"

echo "-n 选项  只打印模式匹配行"
sed -n 'p' sed_file.txt
echo "################"

# 匹配模式固定写法 // 在两个斜杠之间，可以使用正则表达式，前面的两句只有命令p，没有匹配模式，会对文件中的每一行依次处理
sed -n '/python/p' sed_file.txt
echo "################"


echo "-e：直接在命令行进行sed编辑，默认选项"
sed -n -e '/python/p' -e '/PYTHON/p' sed_file.txt
echo "################"


echo "-f：编辑动作保存在文件中，指定文件执行"
sed -n -f edit.sed sed_file.txt
echo "################"


echo "-r：支持扩展正则表达式"
sed -n -r '/python|PYTHON/p' sed_file.txt
echo "################"


echo "-i：直接修改文件内容"
sed -n 's/love/like/g;p' sed_file.txt  # 这里文件没有被修改，只是将替换后的结果从命令行输出
sed -i 's/love/like/g' sed_file.txt # 实际修改了文件
echo "################"
