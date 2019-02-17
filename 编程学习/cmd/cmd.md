# 基本命令

.bat

内部命令
外部命令 （system32中目录中的程序,可自由扩展）
mstsc 远程桌面应用
ping 
wget 下载
wget www.baidu.com

1. 切换目录
cd .. 切换到上级目录
cd . 切换到当前目录
cd / 切换到根目录
f: 切换到f盘

2. 查看目录
dir /? 产看dir命令帮助 
dir /a 查看所有文件（包括隐藏文件）
dir /ah 查看所有隐藏文件
dir /ar 查看只读文件
dir /as 查看系统文件

3. 文件操作
md 创建文件
copy 复制文件
xcopy 复制文件夹
xcopy /S 复制目录及子目录，不包括空目录
xcopy /E 复制目录及子目录，包括空目录
rename 重命名
move 移动文件/重命名文件名
ren 改变为大写
replace 替换文件

if exist 
if exist F:\  (echo 存在) else (echo 不存在) 盘区是否存在
if exist F:\it  (echo 存在) else (echo 不存在) 文件夹是否存在
if exist F:\it.rar  (echo 存在) else (echo 不存在) 文件是否存在

if "字符串1" == "字符串1" (echo equal) else (echo equal) 比较字符串
if /i "字符串1" == "字符串1" (echo equal) else (echo equal) 忽略大小写比较

set /p var1=请输入字符串1：

set var1=hello
set var2=hello
if %var1%== %var2% (echo equal) else (echo equal) 比较变量

## cmd永久变量
setx PATH "%path%;文件夹路径"
setx PATH "%path%;d:"
set 查看环境变量

if exist f:\it (echo exit ) else (md it & echo create success)
if exist f:\it\it.rar (echo exit ) else (type nul>it.rar & echo create success)

## 特殊字符
& 组合命令 当第一个命令执行失败了，后面的命令继续执行
&& 组合命令 当第一个命令执行失败时，后边的命令不会执行
| 命令管道符 将第一条命令的结果作为第二条命令的参数来使用
|| 组合命令 当一条命令失败后才执行第二条命令
()
;

## 分区及格式化磁盘
convert  将FAT 卷转换为NTFS
convert f: /fs:ntfs 
compmgmt
diskpart 
​    list 列举磁盘
​    select disk 1 选择操作的磁盘
​    clean 格式化磁盘
​    creat partition primary 创建主分区
​    format fs=ntfs quick label="E:" 定义磁盘 
​    
文件系统格式 （fat ntfs ExtFAT) (单个文件最大限制，最大文件数量，分区最大容量)
Linux (ext2 ext3 ...)


## 临时提升管理员权限 
hostname 获取主机名
runas /noprofile /user:mymachine\administrator cmd 注意：mymachine需要替换为自己的主机名
runas /user:mymachine\Administrator /sa "C:\Program Files\Internet Explorer\iexplore.exe"

## 设置dos界面
title cmd demo
mode 
mode 80，40
mode 宽度，高度
color
color 12
color、背景颜色 字体颜色

## 管理计算机账号
net user 列举用户
net user 用户名 /add 添加账号
net user 用户名 /del 删除账号
关闭管理员账号
开启管理员账号

## 自动设置IP和DNS
ncpa.cpl
netsh
netsh interface ip set address name= source=static


## 解决端口被占用问题
netstat 查询tcp/ip连接命令
netstat -ano |findstr 62537

tasklist 列举任务进程
taskill 杀死任务进程
taskmgr 打开任务管理器

火绒在线
查看软件是否有病毒






