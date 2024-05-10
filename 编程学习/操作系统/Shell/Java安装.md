# Java安装

[Centos 7 安装 OpenJDK 11 两种方式_centos安装openjdk11-CSDN博客](https://blog.csdn.net/m0_37048012/article/details/120519348)

### 一、下载

[OpenJDK](https://so.csdn.net/so/search?q=OpenJDK&spm=1001.2101.3001.7020)：http://jdk.java.net/java-se-ri/11
清华镜像：https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/

### 二、卸载

> 查看系统是否已安装OpenJDK。一般的linux都默认使用了开源的OpenJDK。

```
查看
rpm -qa | grep java
rpm -qa | grep jdk
批量卸载
rpm -qa | grep jdk | xargs rpm -e --nodeps
rpm -qa | grep java | xargs rpm -e --nodeps
```

### 三、安装

**3.1 第一种方式：yum安装（适用于在线）**

3.1.1 yum安装

```
yum search java-11-openjdk									# 可以不用执行，查找安装包
yum install -y java-11-openjdk java-11-openjdk-devel		# 安装
```

3.1.2 查找JAVA安装目录

```
# 查找安装目录
which java 或 ls -l $(which java)

# 如果显示的是/usr/bin/java请执行下面命令
ls -lr /usr/bin/java
ls -lrt /etc/alternatives/java

# 输出：/etc/alternatives/java -> /usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64/bin/java
# 上面的/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64就是JAVA的安装路径
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/0c9656ad4b934fb1b1d9f708de122b3a.png#pic_left)

3.1.3 配置环境变量

```
# 通过yum方式安装默认安装在/usr/lib/jvm文件下
# 修改JAVA_HOME为/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64
# 编辑/etc/profile文件
vi /etc/profile

# 按" i "键进行编辑，设置环境变量，ESC退出编辑，" :wq "保存内容
# Java Environment
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$PATH

# 使环境变量生效
source /etc/profile
```

**3.2 第二种方式：tar解压安装（适用于离线）**

3.2.1 切换到root用户，在/usr下创建java文件夹

```
su root
mkdir /usr/java
cd /usr/java/
```

3.2.2 上传下载好的OpenJDK文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/ef09cc04bf3940af93b2c380cfcda291.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6JKc5Li2,size_20,color_FFFFFF,t_70,g_se,x_16#pic_left)

3.2.3 tar解压文件

```
tar -zxvf openjdk-11+28_linux-x64_bin.tar.gz
```

3.2.4 配置环境变量

```
# 修改JAVA_HOME为/usr/java/jdk-11
# 编辑/etc/profile文件
vi /etc/profile

# 按" i "键进行编辑，设置环境变量，ESC退出编辑，" :wq "保存内容
# Java Environment
export JAVA_HOME=/usr/java/jdk-11
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$PATH

# 使环境变量生效
source /etc/profile
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/40c78c23c2f14d9dbe3d63b6a6f2341d.png#pic_left)

```
# 检查是否安装成功
java -version
javac 
java
echo $JAVA_HOME
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/bbd7755d584c4c2584a0ecab56f49b26.png#pic_left)

### 四、问题汇总

1.yum安装报错
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200229163944984.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3MDQ4MDEy,size_16,color_FFFFFF,t_70)
解决办法：执行命令 **yum clean all** 即可解决。