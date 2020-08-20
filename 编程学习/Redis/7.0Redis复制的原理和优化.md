什么是主从复制
复制的配置
全量复制和部分复制
故障处理
开发运维常见问题

## 什么是主从复制
主从复制的作用
数据副本
扩展读性能

## 复制的配置
- slaveof命令
slaveof 127.0.0.1:6379 
slaveof no one 

- 配置
slaveof ip port
slave-read-only yes

实验

全量复制和部分复制
run id
redis-cli -p 6379 info server | grep run

偏移量
redis -cli -p 6379 info replication
