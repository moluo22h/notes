路由器设置

```bash
sys
sys Shenzhen
int g0/0/0
ip add 10.1.1.254 24
```

ping 10.1.1.1

save 保存配置

sys 设置名称（sysname）

int 进入那个接口

disp saved-configuration 显示配置文件

disp interface s2/0/0 显示网卡信息

disp ip int brief

dhcp enable 开启dhcp

ip address

```bash
sys
dhcp enable
int g0/0/1
ip address dhcp-alloc
disp ip int brief
disp ip routing-table
```



```bash
ip add 192.168.8.2 24
```



帧中继

```bash
link-protocol fr
ip add 192.168.1.1 24

disp fr map-info
ping 192.168.1.2
ping 192.168.1.3
```

组播

```bash
multicast routing-enable
int g0/0/0
pim dm
int g0/0/1
pim dm
int g0/0/0
igmp enable
```

组播源设置

239.1.1.1



pc机的配置

```
ip      10.1.1.2
mask    255.255.255.0
gateway 10.1.1.254
```



```bash
? 显示帮助信息
ping 10.1.1.254
```







无线控制器配置

```bash
disp current-configuration
```



STA

```
ipconfig
ping 100.100.100.100
ping 100.100.100.100 -t
```

