## 通配符掩码

使用`network + 通配符掩码`指明IP地址范围

通配掩码位格式：**“0”** 表示精确匹配。**“1”** 表示模糊匹配。

你可能注意到，`通配掩码位`格式，恰巧和`子网掩码位`格式相反

ACL中常见的IP地址范围表示形式如下：

- 一个网段的ip，例如192.168.1.0/24网段

  ```bash
  192.168.1.0   0.0.0.255
  ```

- 一台主机ip

  ```bash
  192.168.1.2   0.0.0.0
  ```

  > 提示：对于通配符掩码0.0.0.0，可使用`host`关键字代替，格式为：host + ip，如下
  >
  > ```bash
  > host 192.168.1.2
  > ```
  >
  > 提示：当`标准ACL`中时，甚至host也可以省略

- 任何ip

  ```bash
  0.0.0.0  255.255.255.255
  ```

  > 提示：对于`0.0.0.0  255.255.255.255`，可直接使用any关键字代替
  >
  > ```bash
  > any
  > ```

- 一个网段中的偶数ip

  ```bash
  192.168.1.0   0.0.0.254
  ```

- 一个网段中的奇数ip

  ```bash
  192.168.1.1   0.0.0.254
  ```



## ACL概述

ACL (Access Control List,访问控制列表）是一系列运用到路由器接口的指令列表。这些指令告诉路由器接收哪些数据包、拒绝哪些数据包，接收或者拒绝根据一定的规则进行，如源地址、目标地址、端口号等。ACL使得用户能够管理数据流，检测特定的数据包。



　　顺序执行：—个`ACL列表`中可以包含多个`ACL指令`，ACL指令从**上往下依次匹配**。一旦前面的ACL指令条件满足，将不再匹配后面的ACL指令。

## ACL 类型

- 标准ACL: access-list-number编号1~99之间的整数，只针对`源地址`进行过滤。
- 扩展ACL: access-list-number编号100~199之间的整数，可以同时使用`源地址`和`目标地址`作为过滤条件，还可以针对不同的`协议`、`协议的特征`、`端口号`、`时间范围`等过滤。可以更加细微的控制通信量。
- 动态ACL
- 自反ACL
- 基于时间的ACL



## 标准ACL

access-list-number编号**1~99**之间的整数，只针对**源地址**进行过滤。

ACL仅对穿越路由器的数据包生效，对本路由器起源的数据包不生效。

### 新增标准ACL

配置标准ACL需要两步，一是创建访问控制列表，二是将列表绑定到特定端口。如下：

1. 使用`conf t`切换到全局模式下，执行如下命令格式创建ACL。

   access-list {access-list-number} { deny | permit } { 源地址 [ 源地址通配符掩码 ] | any } [ log ]

   > 参数说明：
   >
   > - access-list-number是1~99的ACL编号；
   > - deny拒绝，permit允许；
   > - log是日志选项，匹配的条目信息显示在控制台上，也可以输出到日志服务器。
   >
   > 注意：访问控制列表最后隐含一条deny any 规则；ACL从上往下匹配，规则顺序不能改变

   

   示例如下： 

   ```bash
   允许网段流量
   R3 (config) #access-list 1 permit 192.168.1.0  0.0.0.255
   
   允许主机流量，以上3种写法等价
   R3 (config) #access-list 1 permit 192.168.1.2
   R3 (config) #access-list 1 permit 192.168.1.2  0.0.0.0
   R3 (config) #access-list 1 permit host 192.168.1.2
   
   允许任意流量
   R3 (config) #access-list 1 permit any
   ```

   

2. 绑定ACL

   创建好列表后，要将ACL绑定到每个它想应用的接口才能实现访问控制功能。

   例如：将上述列表应用到R3的S1/0接口，配置为：

   ```bash
   R3 (config) #interface s1/0　　　　
   R3 (config-if) #ip access-group 1 in　　在接口下调用ACL 1，针对的是从s1/0接口进入路由器R3的流量
   ```

   


### 解绑标准ACL

命令格式：no ip access-group {access-list-number} in

```bash
R3 (config) #int s1/0							# 进入端口s1/0
R3 (config-if) #no ip access-group 1 in        	# 解绑access-list-number编号为1的ACL
```

### 删除标准ACL

命令格式：no access-list {access-list-number} 

```bash
R3 (config) #no access-list 1					# 删除access-list-number编号为1的ACL
```

### 更新标准ACL指令

不支持更新，请先删后加

### 查看标准ACL

命令格式：show access-lists {access-list-number}

```bash
R3#show access-lists							# 查看所有的ACL
R3#show access-lists 1							# 查看access-list-number编号为1的ACL
```

## 标准命名ACL

标准命名ACL指使用**字符串**代替数字来标识ACL

不限制ACL列表个数，可以超过99

### 新增标准ACL

命令格式：ip access-list standard {access-list-name}

```bash
R3 (config)# ip access-list standard deny-R1				# 新建名为deny-R1的标准命令ACL
R3 (config-std-nac1)#deny 12.1.1.1  0.0.0.0			     	# 拒绝主机12.1.1.1的流量
R3 (config-std-nac1)#permit any								# 允许其他任何流量
R3 (config-std-nac1)#exit									


R3 (config)#int s1/0										# 进入端口s1/0
R3 (config-if)#ip access-group deny-R1 in					# 绑定标准命令ACL
```

### 解绑标准ACL

同标准ACL

### 删除标准ACL

命令格式：no ip access-list standard {access-list-name}

```bash
R3 (config)#no ip access-list standard deny-R1				# 删除名为deny-R1的ACL
```

### 更新标准ACL指令

支持两种方式删除ACL指令

1. 根据指令内容删除

   ```bash
   R3 (config)# ip access-list standard deny-R1			# 进入名为deny-R1的标准命令ACL
   R3 (config-std-nac1)#no deny 12.1.1.1					# 删除规则为deny 12.1.1.1的指令
   ```

2. 根据指令行号删除

   ```bash
   R3 (config)# ip access-list standard deny-R1			# 进入名为deny-R1的标准命令ACL
   R3 (config-std-nac1)#no 20								# 删除行号为20的指令
   ```

   

### 查看标准ACL

同标准ACL

## 扩展ACL

### 新增扩展ACL

命令格式：access-list {access-list-number} {permit|deny} ...

```bash
R2 (config) # access-list 100 deny tcp host 12.1.1.1 host 23.1.1.3 eq Telent
R2 (config) # access-list 100 permit ip any any
```



### 解绑扩展ACL

同标准ACL

### 删除扩展ACL

同标准ACL

### 更新扩展ACL指令



### 查看扩展ACL

同标准ACL



## 扩展命令ACL

### 新增扩展命令ACL

命令格式：ip access-list extended {access-list-name}

```bash
ip access-list extended tcp-firewall
```

### 解绑扩展ACL



### 删除扩展ACL



### 更新扩展ACL指令



### 查看扩展ACL







## 参考文档

[思科ACL访问控制列表常规配置](https://blog.csdn.net/brave_stone/article/details/84205901)