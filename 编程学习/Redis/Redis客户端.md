Redis客户端

Java客户端:Jedis
Python客户端：Redis-py

Java客户端:Jedis
Jedis直连
1.生成一个Jedis对象，
2.执行set操作
3.执行get操作

Jedis连接池的使用
Jedis直连
简单方便
使用于少量长期连接的场景



Jedis连接池
1. 从连接池中获取jedis对象
2. 执行操作

方案对比
