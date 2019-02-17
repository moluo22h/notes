通用命令
字符串类型
哈希类型
列表类型
集合类型
有序集合类型

通用命令
keys ：keys * 遍历所有的key keys [pattern]  O(n)
he[h-l]
he*
keys会非常慢：不要在生产环境中使用
O(n)的复杂度

生产环境使用：
热备从节点
scan

dbsize ：数据库大小，计算key的总数 O(1)
内置技术器 O(1) 的复杂度

exists key  O(1)
返回1存在，返回0不存在


del key [key...] 删除指定key-value O(1)
返回1删除成功，返回0表示，删除的key不存在

expire key seconds O(1)
ttl key 查看key的剩余时间 O(1)
-1 key存在，并且没用过期时间 O(1)

persist key 去掉key的过期时间
-2 key已过期

type key ：key 的类型 O(1)
string 
hash
list
set
zset
none


数据结构和内部编码
redisObject
type
encoding
ptr
vm
其他信息





单线程架构
1.纯内存
2.非阻塞IO

100ns



## 字符串
结构和命令
快速实战
内部编码
查缺补漏

value 不能大于512M
key-value 最好 100k以内

场景
缓存
计数器
分布式锁
等等

api 时间复杂度O(1)
get
set
del

incr :自增一
decr
incrby key k 
decrby


实现如下功能
记录网站访问量
实现视频的基本信息
分布式id生成器

set key value 不管key是否存在，都设置
setnx key不存在，才设置 add操作
setxx key存在，才设置 set操作

set key value ex

mget  key1 key2 key3 O(n)
mset 


getset getset key newvalue O(1)
set key newvalue并返回旧的value

append key value O(1)
将value追加到旧的value

strlen key O(1)
返回字符串的长度（注意中文）


incrbyfloat 
getrange 获取字符串指定下表下标的值
setrange



## hash
特点
重要api
hash vs string


key field value
user：1：info 

hget key field O(1)
hset O(1)
hdel O(1)


hexists key field :判断hash key 是否存在field   O (1)
hlen key ： 获取hash key field 的数量 O(1)

hmget O(n)
hmset O(n)

记录网站每个用户个人主页的访问量
hincrby user：1：info pageview 


hgetall 返回hash key 对应所有的field和value  O(n)
hvals 返回hash key 对应的所有的field的value  O(n)
hkeys 返回hash key对应所有field  O(n)


小心hgetall
small redis


key value（serilization：json,xml,）
string v1 编程简单
string v2 直观，可以部分更新  占用内存较大，key较为分散
hash 直观，节省空间，可以部分更新  编程稍微复杂，ttl不好控制

hsetnx
hincrby


## 列表
特点
重要api
实战
查缺补漏

特点
有序
可以重复
左右两边插入弹出


rpush key value1 value2 ... O（1~n）
lpush key value1 value2

插入：linsert key before|after value newValue O（n）
删除：lpop    O（1）
rpop     O（1）
lrem key count value 


修剪 ltrim key start end O(n)

查
lrange key O(n)
lindex key index O(1)
列表长度 llen key O(1)
lset key index newValue O (n)


查缺补漏
blpop key timeout ：lpop阻塞版本 timeout是阻塞超时间 O(1)




##  set集合
sinter 两者共同的
sdiff 
sunion


特点
无序
无重复
集合间操作



api
sadd O(1)
srem O(1)

scard  key :计算集合大小
sismember  key value判断it是否在集合中存在
srandmember  key count从集合中随机挑count个元素
spop 从集合中弹出元素
smembers 返回集合中的所有元素
小心使用

集合内演示
抽奖系统
标签


集合间的api
差集 sdiff
finter
sunion
sdiff|sinter|suion +store 

共同关注




## zset有序集合
特点
重要api
实战
查缺补漏




key   score  value
集合vs有序集合
zadd key score element .... 添加score和element O(logN)
zrem key element ... O(1)
zscore key element 返回元素的分数
zincrby key increScore element O（1）
zcard key :集合总数O(1)
zrank player 

zrange key start end [withscores]  O(log(n)+m)
zcount 返回范围内个数
zremrangebyscore


实战：
排行榜


zrevrank









