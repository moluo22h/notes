

## 策略路由的特点

- 策略路由比所有路由的级别都高，其中包括直连路由。

- 策略路由是转发层面的行为，操作的对象是数据包，匹配的是数据流，具体是指数据包中的各个字段:源IP、目标IP、协议、源端口、目标端口、802.1p优先级 、VLANID 源/目的MAC地址、IP优先级 、DSCP的优先级 、IP的协议类型字段

- 为QoS服务。使用route-map及策略路由可以根据数据包的特征修改其相关QoS项，进行为QoS服务。

- 负载平衡。使用策略路由可以设置数据包的行为，比如下一跳、下一接口等，这样在存在多条链路的情况下，可以根据数据包的应用不同而使用不同的链路，进而提供高效的负载平衡能力。策略路由影响的只是本地的行为，所以可能会引起“不对称路由”形式的流量。比如一个单位有两条上行链路A与B，该单位想把所有HTTP流量分担到A链路，FTP流量分担到Ｂ链路，这是没有问题的，但在其上行设备上，无法保证下行的HTTP流量分担到Ａ链路，FTP流量分担到Ｂ链路。

- 策略路由一般针对的是接口入(in)方向的数据包，但也可在启用相关配置的情况下对本地所发出的数据包也进行策略路由。

## 策略路由的种类：

- 目的地址路由

- 源地址路由

- 智能均衡的策略方式：多条线路不管是光纤还是ADSL，都能自动的识别，并且自动的采取相应的策略方式，是策略路由的发展趋势



## 使用策略路由的步骤

1. 创建ACL

   ```bash
   R1(config)#access-list 11 permit 192.168.11.0 0.0.0.255//用ACL11标记192.168.11.0的流量
   ```

2. 创建路由图

   命令格式：route-map {route-map名称} {permit | deny} {序列号}

   ```bash
   R1(config)#route-map s1 permit 10 						//创建路由图s1，允许流量
   R1(config-route-map)#match ip address 11 				//匹配ACL11的流量
   R1(config-route-map)#set ip next-hop 100.100.100.100	//对匹配ACL11的流量直接转发到ISP1
   R1(config-route-map)#exit
   
   R1(config)#route-map s1 deny 20 						//路由图S1拒绝其他所有流量
   R1(config-route-map)#exit
   ```

3. 在接口上应用路由图

   命令格式：ip policy route-map {route-map名称}

   ```bash
   R1(config)#interface fa0/0
   R1(config-if)#ip policy route-map s1 //在接口下应用路由图S1
   R1(config-if)#exit
   ```

   

## 参考文档

[CCNP路由实验之十六 策略路由(PBR)](https://blog.csdn.net/kkfloat/article/details/39940623)

