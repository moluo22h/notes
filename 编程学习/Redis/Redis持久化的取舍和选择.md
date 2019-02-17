持久化的作用
RDB
AOF
RDB和AOF的抉择

## 持久化的作用
1. 什么是持久化
redis所有数据保持在内存中，对数据的更新将异步地保存在磁盘中。

2. 持久化的实现方式
快照 MySQL Dump、 Redis RDB
写日志 MySQL Binlog、Hbase  HLog、Redis AOF

## RDB
1. 什么是RDB
RDB文件(二进制)

2. 触发机制-主要3种方式
- save（同步）
	生成RDB文件（二进制），存在阻塞
	复制度O（n）
	
- bgsave（异步）
	fork() → RDB文件（二进制）→
	复制度O（n）

- 自动
save 900 1
save 300 10
save 60 10000
	dbfilename dump.rdb	dump-${port}.rdb
	dir ./	dir /bigdiskpath
stop-writes-on-bgsave-error yes
rdbcompression yes

3. 触发机制-不用忽略方式
- 全量复制
- debug reload
- shutdown
都会生成rdb文件

4. 实验
redis data config redis-config














