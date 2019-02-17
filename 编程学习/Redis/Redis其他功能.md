慢查询
pipeline
发布订阅
Bitmap
HyperLogLog
GEO


## 慢查询
生命周期
两个配置
三个命令
运维经验

生命周期
1.发送命令
2.排队
3.执行命令
4.返回结果

慢查询发生在执行命令阶段

两个配置
先进先出
固定长度
保存在内存中

慢查询阈值
1.默认值
config get showlog-max-len=128
config get slowlog-log-shower-than=10000
2.修改配置文件重启
3.动态配置
config set slowlog-max-len 1000
config set slowlog-log-slower-than1000

慢查询命令
1. slowlog get[n]:获取慢查询队列
2. slowlog len:获取慢查询队列长度
3. slowlog reset：清空慢查询队列

运维经验
1. slowlog-max-len不要设置过大，默认10ms，通常设置1ms
2. slowlog-log-lower-than不要设置过小，通常设置1000左右。
3. 理解命令生命周期
4. 定期持久化慢查询

## pipeline
什么是流水线
客户端实现

```java
Jedis jedis=new Jedis("127.0.0.1",6379);

```

1.注意每次pipeline携带数据量
2.pipeline每次只能作用在一个Redis节点上
3.pipeline与M操作的区别

