# Jumpserver部署安装

## 一、设置防火墙和selinux

```bash
firewall-cmd --zone=public --add-port=80/tcp --permanent    # nginx端口
firewall-cmd --zone=public --add-port=2222/tcp --permanent  # 用户SSH登录端口coco
firewall-cmd --reload                                       # 重新载入规则
setenforce 0
sed –i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
```



## 二、准备Python3和Python虚拟环境

### 1、安装依赖包

```bash
yum install epel-release -y
yum -y install git python-pip mariadb-devel gcc automake autoconf python-devel sshpass readline-devel mysql-devel 
```

### 2、安装Python3.6

```bash
yum -y install python36 python36-devel

# 如果下载速度很慢, 可以换国内源
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum -y install python36 python36-devel
```

### 3、建立Python虚拟环境

因为 CentOS 7 自带的是 Python2, 而 Yum 等工具依赖原来的 Python, 为了不扰乱原来的环境我们来使用 Python 虚拟环境。

```bash
cd /opt
python3.6 -m venv py3           #创建虚拟环境，环境命令自定义为py3
source /opt/py3/bin/activate    #运行虚拟化境

# 看到下面的提示符代表成功, 以后运行 Jumpserver 都要先运行以上 source 命令, 以下所有命令均在该虚拟环境中运行
(py3) [root@localhost py3]                 
# 出现以上字符代表运行成功
```

## ![img](https://img2020.cnblogs.com/i-beta/857064/202003/857064-20200318154914986-1630329561.png)

## 三、安装JumpServer

### 1、下载或 Clone 项目

项目提交较多 git clone 时较大, 你可以选择去 Github 项目页面直接下载zip包

```bash
cd /opt/
git clone https://github.com/jumpserver/jumpserver.git
```

### 2、安装RPM依赖包

```bash
cd /opt/jumpserver/requirements
yum -y install $(cat rpm_requirements.txt)      # 如果没有任何报错请继续
```

### 3、安装Python库依赖

```bash
pip install -r requirements.txt
```

 ![img](https://img2020.cnblogs.com/i-beta/857064/202003/857064-20200318154957083-761472963.png)

```bash
报错：需要更新pip 
解决：pip install --upgrade pip 然后再次安装 

# 如果下载速度很慢, 可以换国内源
pip install --upgrade pip setuptools -i https://mirrors.aliyun.com/pypi/simple/ # 更换阿里源
pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/		# 再次安装
```

### 4、安装 Redis

```bash
yum -y install redis
systemctl start redis && systemctl enable redis
```

### 5、安装Mysql数据库

本教程使用 Mysql 作为数据库, 如果不使用 Mysql 可以跳过相关 Mysql 安装和配置

#### （1）、安装Mysql数据库

```bash
yum -y install mariadb mariadb-devel mariadb-server mariadb-shared
```

#### （2）、启动数据库并设置开机自启

```bash
systemctl start mariadb && systemctl enable mariadb
```

#### （3）、创建JumpServer数据库并授权（切记不要自己设置密码）

```bash
DB_PASSWORD=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 24`    # 生成随机数据库密码
echo -e "\033[31m 你的数据库密码是 $DB_PASSWORD \033[0m"

mysql -uroot -e "create database jumpserver default charset 'utf8'; grant all on jumpserver.* to 'jumpserver'@'localhost' identified by '$DB_PASSWORD'; flush privileges;"
```



### 6、修改jumpserver配置文件

#### （1）、修改配置文件

```bash
cd /opt/jumpserver
cp config_example.yml config.yml

SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50` # 生成随机SECRET_KEY
echo "SECRET_KEY=$SECRET_KEY" >> ~/.bashrc

BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16` # 生成随机BOOTSTRAP_TOKEN
echo "BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN" >> ~/.bashrc

sed -i "s/SECRET_KEY:/SECRET_KEY: $SECRET_KEY/g" /opt/jumpserver/config.yml
sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" /opt/jumpserver/config.yml
sed -i "s/# DEBUG: true/DEBUG: false/g" /opt/jumpserver/config.yml
sed -i "s/# LOG_LEVEL: DEBUG/LOG_LEVEL: ERROR/g" /opt/jumpserver/config.yml
sed -i "s/# SESSION_EXPIRE_AT_BROWSER_CLOSE: false/SESSION_EXPIRE_AT_BROWSER_CLOSE: true/g" /opt/jumpserver/config.yml
sed -i "s/DB_PASSWORD: /DB_PASSWORD: $DB_PASSWORD/g" /opt/jumpserver/config.yml
echo -e "\033[31m 你的SECRET_KEY是 $SECRET_KEY \033[0m"
echo -e "\033[31m 你的BOOTSTRAP_TOKEN是 $BOOTSTRAP_TOKEN \033[0m"
```



#### （2）、配置文件说明

```bash
# SECURITY WARNING: keep the secret key used in production secret!

# 加密秘钥 生产环境中请修改为随机字符串, 请勿外泄
SECRET_KEY:

# SECURITY WARNING: keep the bootstrap token used in production secret!
# 预共享Token coco和guacamole用来注册服务账号, 不在使用原来的注册接受机制
BOOTSTRAP_TOKEN:

# Development env open this, when error occur display the full process track, Production disable it
# DEBUG 模式 开启DEBUG后遇到错误时可以看到更多日志
DEBUG: false

# DEBUG, INFO, WARNING, ERROR, CRITICAL can set. See https://docs.djangoproject.com/en/1.10/topics/logging/
# 日志级别
LOG_LEVEL: ERROR

# LOG_DIR:
# Session expiration setting, Default 24 hour, Also set expired on on browser close
# 浏览器Session过期时间, 默认24小时, 也可以设置浏览器关闭则过期
# SESSION_COOKIE_AGE: 86400
SESSION_EXPIRE_AT_BROWSER_CLOSE: true

# Database setting, Support sqlite3, mysql, postgres ....
# 数据库设置
# See https://docs.djangoproject.com/en/1.10/ref/settings/#databases
# SQLite setting:
# 使用单文件sqlite数据库
# DB_ENGINE: sqlite3
# DB_NAME:

# MySQL or postgres setting like:
# 使用Mysql作为数据库
DB_ENGINE: mysql
DB_HOST: 127.0.0.1
DB_PORT: 3306
DB_USER: jumpserver
DB_PASSWORD:
DB_NAME: jumpserver

# When Django start it will bind this host and port
# ./manage.py runserver 127.0.0.1:8080
# 运行时绑定端口
HTTP_BIND_HOST: 0.0.0.0
HTTP_LISTEN_PORT: 8080
 
# Use Redis as broker for celery and web socket
# Redis配置
REDIS_HOST: 127.0.0.1
REDIS_PORT: 6379
# REDIS_PASSWORD:
# REDIS_DB_CELERY: 3
# REDIS_DB_CACHE: 4

# Use OpenID authorization
# 使用OpenID 来进行认证设置
# BASE_SITE_URL: http://localhost:8080
# AUTH_OPENID: false  # True or False
# AUTH_OPENID_SERVER_URL: https://openid-auth-server.com/
# AUTH_OPENID_REALM_NAME: realm-name
# AUTH_OPENID_CLIENT_ID: client-id
# AUTH_OPENID_CLIENT_SECRET: client-secret

# OTP settings
# OTP/MFA 配置
# OTP_VALID_WINDOW: 0
# OTP_ISSUER_NAME: Jumpserver
```



#### （3）、运行Jumpserver

```bash
cd /opt/jumpserver/
./jms start all -d      # 后台运行使用 -d 参数. ./jms start|stop|status all
```

 ![img](https://img2020.cnblogs.com/i-beta/857064/202003/857064-20200318155042101-1076440191.png)

至此JumpServer安装告一段落 接下来进入其他服务安装



## 参考文档

[JumpServer开源跳板机部署文档](https://www.cnblogs.com/zhangan/p/12518023.html)