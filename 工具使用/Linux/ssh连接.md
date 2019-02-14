# SSH连接虚拟机中的Ubuntu（转）
摘要：主要是解决不能使用ssh远程Ubuntu的问题、使用的远程工具是putty、也可以使用xshell、ubunut12.0.4是装在虚拟机中的、不过这个应该没有什么影响。

## 问题的出现

前两天使用VMware装了一个ubuntu12.0.4之后、因为常常使用命令行、又喜欢在虚拟机与实体机中切来切去、感觉很不方便、就想在xp中远程ubuntu、遇到了点小意外、经过一会调试解决成功、把过程记录一下、好记性不如烂笔头。

在开始连接的时候、老是连接不成功、就想着具体是哪方面的问题、按照思路一步一步来验证。

## 具体的解决过程

1、网络

既然要远程ubuntu的系统、那么首先是两个网络是不是在一个网段、能不能ping的通？

a）  Windows电脑上——cmd 打开命令窗口、键入：ipconfig 命令、查看主机IP。

b）  ubuntu系统、ctrl + alt + F1打开命令终端、键入ifconfig 命令、查看ubuntu上网IP。

c）  然后在ubuntu系统终端键入：ping +Windows上网的IP、查看是否ping的通、不可以则检查网络情况、以及是否在一个网段、ping的通在进行下一步

d）  在Windows命令窗口中键入：ping +ubuntu 上网IP、查看是否ping的通、不可以则检查网络情况、以及是否在一个网段、ping的通在进行下一步

2、ssh服务

既然是通过sshserver来进行远程、那么当网路通畅之后要解决的就是关于ubuntu系统的ssh问题。

a）  查看是否安装ssh服务

在ubuntu终端命令界面键入：

ssh localhost

如果出现下面提示则表示还没有安装：

ssh: connect to hostlocalhost port 22: Connection refused 

 b）  安装ssh服务

如果通过上面步骤查看没有安装sshserver、则键入如下命令安装：

sudo apt-get install –y openssh-server 

c）安装完成后启动ssh

service ssh start 

d）  启动完成之后可以使用命令：ps –e | grep ssh 来查看ssh状态、

6455 ?        00:00:00 sshd 

则表明启动成功。

再使用putty连接ubuntu、问题解决。

## 推荐阅读：

1、PuTTY

如何通过Putty实现远程登录控制Linux平台 http://www.linuxidc.com/Linux/2013-06/85266.htm

Putty连接VMWare中Ubuntu的问题解决 http://www.linuxidc.com/Linux/2013-05/84819.htm

VMware+Linux+Putty环境配置 http://www.linuxidc.com/Linux/2013-05/84818.htm

借助Putty远程登录控制虚拟机的Fedora系统 http://www.linuxidc.com/Linux/2013-01/78155.htm

2、Xshell

secureCRT和Xshell登录Ubuntu http://www.linuxidc.com/Linux/2012-04/58745.htm

更多Ubuntu相关信息见Ubuntu 专题页面 http://www.linuxidc.com/topicnews.aspx?tid=2

共享资源，帮助你我他

## 开启root用户ssh权限

1.输入命令"sudo apt -y install openssh-server"，等待完成openssh-server安装。
2.编辑配置 sudo vi/etc/ssh/sshd_config
3.在行"#PermitRootLogin prohibit-password"后添加行"PermitRootLogin yes"并保存。
4.输入命令"sudo update-rc.d ssh defaults"开启ssh服务开机自启动
5.输入命令"sudo service sshd start"启动服务
6.输入命令"sudo service sshd status"查看服务运行状态，"active(running)"说明服务正常。