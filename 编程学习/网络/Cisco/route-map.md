

在每一个序列中，可定义供策略部署的两个元素：匹配条件（match语句）和执行动作（set语句）。你也可以定义多个条件，当条件被匹配时，就会去执行set指定的相关动作（set语句并非必须，例如：若route-map仅用于匹配感兴趣流量，则不需要set语句）。route-map被调用后，匹配动作将会从最小的序列号开始执行，如果该序列号中的条件都被匹配了，则执行set命令，若条件不匹配，则切换到下一个序列号继续进行匹配动作。



四、Route-map的特点

使用match命令匹配特定的分组或路由，set修改该分组或路由相关属性。

Route-map中的每个序列号语句相当于访问控制列表中的各行。

Route-map默认为permit，默认序列号为10，序列号不会自动递增，需要指定序列号。

末尾隐含deny any。

单条match语句包括多个条件时，使用逻辑or运算；多条match语句时，使用逻辑and运算。



## 五、route-map配置命令

### 1.创建route-map

命令格式：route-map {route-map名称} { permit | deny } {序列号}

参数说明：

- 序列号：一个*route map*可以包含多个*route map statement*，序列号参数决定了进行条件匹配的顺序。只有序列号为*10*的语句没有匹配，才会检查序列号为*20*的语句才被检查。

```bash
R1(config)#route-map internet permit 10 		// 创建名为internet的路由图
```



### 2.定义匹配条件

- match ip address {ACL number|name} […ACL number|name]：匹配访问列表或前缀列表
- match length {min} {max} ：根据分组的第三层长度进行匹配
- match interface匹配下一跳出接口为指定接口之一的路由
- match ip next-hop {ip-address}：匹配下一跳地址为特定访问列表中被允许的那些路由
- match metric匹配具有指定度量值的路由
- match route-type匹配指定类型的路由
- match community匹配BGP共同体
- match tag根据路由的标记进行匹配



### 3.定义set动作

- set metric设置路由协议的度量值
- set metric-type设置目标路由协议的度量值类型
- set default interface指定如何发送这样的分组
- set interface指定如何发送这样的分组
- set ipdefault next-hop指定转发的下一跳
- set ip next-hop指定转发的下一跳
- set next-hop指定下一跳的地址，指定BGP的下一跳
- set as-path
- set community
- set local-preference
- set weight
- set origin
- set tag
- default关键字优先级低于明细路由



### 示例

```bash
R1(config)#route-map internet permit 10 		// 创建名为internet的路由图
R1(config-route-map)#match ip address 1 		// 设置匹配ACL编号为1的流量
R1(config-route-map)#set interface null0 		// 对符合的流量设置下一跳接口为null0，即掉弃
```

