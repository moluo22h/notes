#!/usr/bin/env bash

# 自定义配置
## 生成配置的文件名
out_file="SUMMARY.md"
## 需要排除的文件夹相对路径，示例：exclude_dir_names=("_book" "media" "代码问题" "思维碎片" "工具使用" "经历攻略" "编程学习" "Maven")
#exclude_dir_names=("_book" "代码问题" "思维碎片" "经历攻略" "编程学习" "工具使用/Maven")
exclude_dir_names=("_book")
## 需要排除的文件相对路径
exclude_file_names=("$out_file" "`basename $0`" "SUMMARY.md")

# 记录当前所在的路径
base_path="$PWD"
# 将会填充空格
sblank="    "
# sblankblank将会填充在$sblank后面
sblankblank="* "

#tree函数，该函数实现tree的功能
tree()
{
    current_relative_path=$(get_relative_path "$base_path" "$PWD")

    #for循环，搜索该目录下的所有文件和文件夹
    for file in *;
    do

        # 如果是文件的话，将该文件名写入$out_file
        if [ -f "$file" ]; then
            # 文件的相对路径
            relative_file=$(get_file_relative_path "$current_relative_path" "$file")

            # 标志位-用于判断文件是否需要排除。"0"表示不需要排除，"1"表示需要排除
            is_exclude_file=0

            # 排除README.md文件
            if [ "README.md" == "$file" ]; then
                is_exclude_file=1
                echo "exclude file: $relative_file"
                continue;
            fi

            # 排除格式非.md的文件
            if [[ "md" != "${file##*.}" ]]; then
                is_exclude_file=1
                echo "exclude file: $relative_file"
                continue;
            fi

            # 排除$exclude_file_names数组中的文件
            for exclude_file_name in ${exclude_file_names[@]}
            do
                if [[ "${exclude_file_name}" == "$relative_file" ]]; then
                    is_exclude_file=1
                    echo "exclude file: $relative_file"
                    break
                fi
            done

            # 打印
            if [ $is_exclude_file -eq 0 ];then
                echo "${sblankblank}[${file%.*}]($relative_file)" >> "${base_path}/$out_file"
            fi
        fi

        # 如果是文件夹的话，将该文件夹的名称写入$out_file
        if [ -d "$file" ]; then
            # 文件夹的相对路径
            relative_dir=$(get_file_relative_path "$current_relative_path" "$file")

            # 标志位-用于判断文件是否需要排除。"0"表示不需要排除，"1"表示需要排除
            is_exclude_dir=0

            # 排除media文件夹
            if [ "media" == "$file" ]; then
                is_exclude_dir=1
                echo "exclude dir : $relative_dir"
                continue;
            fi

            # 排除$exclude_dir_names数组中的目录
            for exclude_dir_name in ${exclude_dir_names[@]}
            do
                if [ "$exclude_dir_name" == "$relative_dir" ]
                then
                    is_exclude_dir=1
                    echo "exclude dir : $relative_dir"
                    break
                fi
            done

            if [ $is_exclude_dir -eq 0 ];then
                #1、将该文件夹的名称写入$out_file
                echo "${sblankblank}[${file%.*}]($(get_file_relative_path "$current_relative_path" "$file/README.md"))" >> "${base_path}/$out_file"
                #2、在“* ”的前面填充“    ”
                sblankblank=${sblank}${sblankblank}
                #3、进入该文件夹,递归
                cd "$file"
                tree
                cd ..
                current_relative_path=$(get_relative_path "$base_path" "$PWD")
                #6、从文件夹里出来之后，将在“* ”的前面填充的“    ”删除
                sblankblank=${sblankblank#${sblank}}
            fi
        fi
    done
}


# 比较两个路径，获取相对路径
## 用法：get_relative_path PARENT_ABSOLUTE_PATH CURRENT_ABSOLUTE_PATH
## 示例1：get_relative_path "/main" "/main/sub/hello.txt" 结果为："sub/hello.txt"
## 示例2：get_relative_path "/main" "/main"               结果为：""
get_relative_path(){
    parent_absolute_path=$1
    current_absolute_path=$2

    if [ "$current_absolute_path" == "$parent_absolute_path" ]; then
        echo ""
    else
        echo "${current_absolute_path#*$parent_absolute_path/}"
    fi
}

# 拼接 路径+文件名
## 用法：get_relative_path PARENT_ABSOLUTE_PATH FILE_NAME
## 示例1：get_file_relative_path "/main" "hello.txt" 结果为："/main/hello.txt"
## 示例2：get_file_relative_path ""      "hello.txt" 结果为："hello.txt"
get_file_relative_path(){
    parent_absolute_path=$1
    file_name=$2
    if [ "$parent_absolute_path" == "" ]; then
        echo "$file_name"
    else
        echo "$parent_absolute_path/$file_name"
    fi
}

echo "# Summary" > "${base_path}/$out_file"
echo "">> "${base_path}/$out_file"

tree
