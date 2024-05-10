# Nacos问题记录

## 一、问题概述

Nacos连接外部Mysql数据库报错：`Caused by: java.lang.IllegalStateException: No DataSource set`

## 二、问题起因

跟随官方文档 [Nacos Docker 快速开始](https://nacos.io/zh-cn/docs/quick-start-docker.html)，使用docker-compose部署Nacos，发现需要部署`nacos/nacos-mysql:8.0.16`。但我已有部署好数据库，内心十分抵触再部署`nacos/nacos-mysql:8.0.16`，于是我便开始了我的作死之路

1. 下载nacos的sql文件。地址：[nacos/nacos-db.sql at 2.0.4 · alibaba/nacos · GitHub](https://github.com/alibaba/nacos/blob/2.0.4/config/src/main/resources/META-INF/nacos-db.sql)（注意：不同版本的Nacos所需的sql可能不同，使用时请切换对应分支，我使用的2.0.4分支）

2. 在自己的数据库中创建名为“nacos”的数据库，并导入步骤1中的sql文件

3. 编写nacos启动时所需的环境配置文件：nacos-standlone-mysql.env

   ```bash
   PREFER_HOST_MODE=hostname
   MODE=standalone
   SPRING_DATASOURCE_PLATFORM=mysql
   MYSQL_SERVICE_HOST=192.168.1.3
   MYSQL_SERVICE_DB_NAME=nacos
   MYSQL_SERVICE_PORT=3306
   MYSQL_SERVICE_USER=nacos
   MYSQL_SERVICE_PASSWORD=nacos
   MYSQL_SERVICE_DB_PARAM=characterEncoding=utf8&connectTimeout=3000&socketTimeout=3000&autoReconnect=true&useSSL=false
   ```

4. 编写docker-compose.yaml（说明：根据[standalone-mysql-8.yaml](https://github.com/nacos-group/nacos-docker/blob/v2.0.4/example/standalone-mysql-8.yaml)改编）

   ```yaml
   version: "2"
   services:
     nacos:
       image: nacos/nacos-server:v2.0.4
       container_name: nacos
       env_file:
         - ./nacos-standlone-mysql.env
       ports:
         - "8848:8848"
         - "9848:9848"
         - "9555:9555"
       volumes:
         - ./standalone-logs/:/home/nacos/logs
         - ./init.d/custom.properties:/home/nacos/init.d/custom.properties
       restart: always
   ```

   OK，万事具备。自信满满的执行`docker compose up`安装Nacos，然后灰溜溜的收获如下报错：

   ```bash
   Error creating bean with name 'asyncNotifyService': Unsatisfied dependency expressed through field 'dumpService'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'externalDumpService': Invocation of init method failed; nested exception is ErrCode:500, ErrMsg:Nacos Server did not start because dumpservice bean construction failure :
   Caused by: java.lang.IllegalStateException: No DataSource set
   ```

   出现问题不要怕，开始排查。

## 三、排除步骤

排除步骤如下：

1. 检查env环境配置中的数据库相关信息是否正确。经排除，没问题

   其中安装时使用的env文件如下：

   ```bash
   # cat nacos-standlone-mysql.env 
   PREFER_HOST_MODE=hostname
   MODE=standalone
   SPRING_DATASOURCE_PLATFORM=mysql
   MYSQL_SERVICE_HOST=192.168.1.3
   MYSQL_SERVICE_DB_NAME=nacos
   MYSQL_SERVICE_PORT=3306
   MYSQL_SERVICE_USER=nacos
   MYSQL_SERVICE_PASSWORD=nacos
   MYSQL_SERVICE_DB_PARAM=characterEncoding=utf8&connectTimeout=3000&socketTimeout=3000&autoReconnect=true&useSSL=false
   ```

2. 检查数据库账号是否允许远程连接。（注意：一般root账号默认不允许远程连接）

   ```mysql
   mysql -h 192.168.1.3 -P 3306 -u root -p;
   
   mysql> use mysql;
   
   mysql> select User,Host from user;
   +------------------+-----------+
   | User             | Host      |
   +------------------+-----------+
   | nacos            | %         |  // % 代表允许所有ip来源连接mysql，故远程连接也没问题
   | root             | %         |
   | mysql.infoschema | localhost |
   | mysql.session    | localhost |
   | mysql.sys        | localhost |
   | root             | localhost |
   +------------------+-----------+
   6 rows in set (0.01 sec)
   ```

   上述结果显示：nacos和root经允许远程连接，那看起来也不是远程连接的问题

3. 检查账号加密方式

   ```mysql
   mysql> select User,plugin from user;
   +------------------+-----------------------+
   | User             | plugin                |
   +------------------+-----------------------+
   | nacos            | caching_sha2_password |
   | root             | caching_sha2_password |
   | mysql.infoschema | caching_sha2_password |
   | mysql.session    | caching_sha2_password |
   | mysql.sys        | caching_sha2_password |
   | root             | caching_sha2_password |
   +------------------+-----------------------+
   6 rows in set (0.00 sec)
   ```

   结果显示：加密方式为caching_sha2_password，而**nacos需要使用mysql_native_password**。

   既然加密方式就是罪魁祸首，那我们使用如下命令更改加密方式。

   ```mysql
   mysql> alter user nacos@'%' identified with mysql_native_password by 'nacos';
   Query OK, 0 rows affected (0.01 sec)
   
   mysql> FLUSH PRIVILEGES;
   Query OK, 0 rows affected (0.00 sec)
   ```

   重新部署nacos，成功。

   ```bash
   Nacos started successfully in stand alone mode. use external storage
   ```

   