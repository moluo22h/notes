Redis初识
速度快：10w OPS
数据存储位置：存在内存中
语言：C语言
线程模型：单线程

Register
L1  chthe
L2 cathe
main

持久化：断电不丢失
Redis所有数据保持在内存中，对数据的更新将异步保存在磁盘中

数据结构
Strings/Blobs/Bitmaps
Hash table
set
sort set
list

BitMaps
HyperLogLog：超小内存唯一值计数
GEO：地理位置定位


多语言客户端
java、php、ruby、lua。。。。

功能丰富
分布订阅
Lua脚本
事务
pipeline


简单
23.000 lines of code
不依赖外部库
单线程模型

复制
主服务器 从服务器
主从复制

高可用、分布式
Redis-Sentinel（）支持高可用
Redis-Cluster支持分布式

Redis的典型应用场景
- 缓存系统
- 计数器
- 消息队列系统
- 排行榜
- 社交网络
- 实时系统

缓存系统
App Server
cache
Storage

计数器
incre

消息队列系统


排行榜
有序集合

实时系统
垃圾邮件过滤


redis三种启动方式
Redis安装
可执行文件说明

redis-serve redis服务端
redis-cli redis客户端
redis-benchmark 性能测试
redis-check-aof aof文件修复工具
redes-check-dump
redis-sentinel


最简启动
redis-server
ps -ef | grep

动态参数启动

redis-server --port 6380


配置文件启动
redis-server 

生产环境选择配置启动

单机多实例配置文件


redis客户端连接
redis-cli -h 10.10.79.150 -p 6384

状态回复
错误回复
整数回复
字符串回复
多行字符串回复


redis常用配置
daemonize 是否是守护进程
port 
logfile reids系统日志
dir redis工作目录

RDB config
AOF config


config get *

log





