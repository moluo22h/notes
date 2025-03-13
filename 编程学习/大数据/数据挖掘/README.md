# 数据挖掘部署手册

## 前置条件

请提前在服务器中安装以下软件：

- Docker
- Nginx

## 部署包结构说明

```bash
images: docker镜像包
middleware: 中间件持久化文件
nebula: 服务持久化文件
```

## 	中间件安装

### installMariadb

```bash
# 创建持久化目录
mkdir -p /data/middleware/mariadb/

# 解压
tar -xvf mariadb-data.tar -C /data/middleware/mariadb/

# 拉取镜像
docker pull bitnami/mariadb:10.5.19-debian-11-r29

# 运行容器
docker run -d --name mariadb --restart always -e MARIADB_ROOT_PASSWORD=N2XRLTsJ2t -p 3306:3306 -v /data/middleware/mariadb/data:/bitnami/mariadb/data bitnami/mariadb:10.5.19-debian-11-r29
```

### installCassandra

```bash
# 拉取镜像
docker pull bitnami/cassandra:3.11.11-debian-10-r4

# 运行容器
docker run -d --name cassandra --restart always -p 9042:9042 bitnami/cassandra:3.11.11-debian-10-r4
```

### installRedis

```bash
# 拉取镜像
docker pull bitnami/redis:6.2.2-debian-10-r0

# 运行容器
docker run -d --name redis --restart always -p 6379:6379 -e REDIS_PASSWORD=wKffDkYpwS bitnami/redis:6.2.2-debian-10-r0
```

### installMinio

```bash
# 创建持久化目录
mkdir -p /data/middleware/minio/data

# 解压
tar -xvf minio-data.tar -C /data/middleware/minio/data

# 添加权限
chown -R 1001:1001 /data/middleware/minio/data/

# 拉取镜像
docker pull bitnami/minio:2022.8.22-debian-11-r0

# 运行容器
docker run -d --name minio --restart always -p 9000:9000 -p 9001:9001 -e MINIO_ROOT_USER=admin -e MINIO_ROOT_PASSWORD=Qc8ydPvzq2 -v /data/middleware/minio/data:/data bitnami/minio:2022.8.22-debian-11-r0
```

### installPostgresql

```bash 
# 创建持久化目录
mkdir -p /data/middleware/postgresql/

# 解压
tar -xvf postgresql-data.tar -C /data/middleware/postgresql/

# 导入镜像，注意：该镜像基于官方镜像，新增plpython3u扩展
docker load < postgresql.tar

# 运行容器
docker run -d --name postgresql --restart always -p 5432:5432 -e POSTGRESQL_PORT_NUMBER=5432 -e POSTGRESQL_VOLUME_DIR=/bitnami/postgresql -e PGDATA=/bitnami/postgresql/data -e POSTGRES_PASSWORD=UbGJR1ymQC -e POSTGRESQL_ENABLE_LDAP=no -e POSTGRESQL_ENABLE_TLS=no -e POSTGRESQL_LOG_HOSTNAME=false -e POSTGRESQL_LOG_CONNECTIONS=false -e POSTGRESQL_LOG_DISCONNECTIONS=false  -e POSTGRESQL_PGAUDIT_LOG_CATALOG=off -e POSTGRESQL_CLIENT_MIN_MESSAGES=error -e POSTGRESQL_SHARED_PRELOAD_LIBRARIES=pgaudit -v /data/middleware/postgresql/data:/bitnami/postgresql/data bitnami/postgresql:14.4.0-debian-11-r9-20220729
```

### installJupyterhub

```bash
# 创建持久化目录
mkdir -p /data/middleware/jupyterhub/

# 拉取镜像
docker pull jupyterhub/jupyterhub:1.5.1

# 运行容器
docker run -d --name jupyterhub --restart always -p 8000:8000 -p 8081:8081 -v /data/middleware/jupyterhub/conf/jupyterhub_config.py:/etc/jupyterhub/jupyterhub_config.py jupyterhub/jupyterhub:1.5.1 jupyterhub -f=/etc/jupyterhub/jupyterhub_config.py --no-ssl

# 进入容器
docker exec -it jupyterhub bash

# 安装notebook，注意：版本不能变
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple notebook==6.5.2

# 创建用户，密码均使用nebula@2021
adduser admin
adduser user_1
```

注意事项：待容器起来后，必须执行以下操作

- 访问http://ip:8000，使用admin账户登录，以初始化admin工作空间

- 访问http://ip:8000，使用user_1账户登录，以初始化user_1工作空间

## 服务安装

### installAiworksAlgo

创建持久化目录

```bash
mkdir -p /data/nebula/algo/conf/
mkdir -p /data/nebula/algo/data/
```

创建配置文件/data/nebula/algo/conf/config.yaml

```yaml
mysql:
  url: jdbc:mysql://172.17.0.1:3306/aiworks
  host: 172.17.0.1
  port: 3306
  user: root
  password: N2XRLTsJ2t
  dbname: aiworks
  driver: com.mysql.cj.jdbc.Driver
gp:
  url: jdbc:postgresql://172.17.0.1:5432/aiworks
  host: 172.17.0.1
  port: 5432
  user: postgres
  password: UbGJR1ymQC
  dbname: aiworks
  driver: org.postgresql.Driver
minio:
  address: "http://172.17.0.1:9000"
  access_key: "admin"
  secret_key: "Qc8ydPvzq2"
  connection: client
metrics_path_tmp: ml_model.
insight_server: https://jianwei.zjvis.net/api
model:
  path: static/model_demo
database:
  OLTP: mysql
  OLAP: greenplum
am_warehouse: /opt/file_models/
log_path: /app/logs
```

解压

```bash
tar -xvf file_models.tar -C /data/nebula/algo/data/
```

创建容器

```bash
# 导入镜像
docker load < aiworks-algo-flask.tar

# 运行容器
docker run -d --name aiworks-algo-flask --restart always -p 5000:5000 -v /data/nebula/algo/conf/config.yaml:/app/config/config.yaml insecure.docker.registry.local:80/aiworks-algo-flask:1.0.0-C7794598
```

测试是否部署成功

```bash
http://ip:5000/healthy/liveness
```

### installAiworksBackend

创建持久化目录

```bash
mkdir -p /data/nebula/backend/conf/
mkdir -p /data/nebula/backend/data/
```

创建配置文件/data/nebula/backend/conf/application.yaml

```yaml
app:
  server:
    port: 8080
  sampling: true
  socketio:
    port: 1080
    boss-count: 1
    work-count: 100
    allow-custom-requests: true
    upgrade-timeout: 1000000
    ping-timeout: 6000000
    ping-interval: 25000

restful:
  flaskServer:
    address: "http://172.17.0.1:5000"
  insightServer:
    address: "https://jianwei.zjvis.net/api"
    frontend: "https://jianwei.zjvis.net/"

upload:
  large-file-threshold: 50MB
  is-win: false
  chunk-size: 5242880
  folder-path: ./file_uploads
  expire-time: 1209600
  temp-file-path: ./csv_tmp/
  shp2pgsql-path: /usr/bin/shp2pgsql
  gis:
    file-path: ./gis_data/
  photo:
    resource-path: nebula
    path: vis/wordcloud/
  case:
    video-path: vis/caseVideo/
  model:
    folder-path: /opt/file_models/

spring:
  application:
    name: datascience
  servlet:
    multipart:
      max-request-size: 1GB
      max-file-size: 1GB
  output:
    ansi:
      enabled: always
  jackson:
    time-zone: GMT+8
  mvc:
    async:
      request-timeout: 600000
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://172.17.0.1:3306/aiworks?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true&useAffectedRows=true&serverTimezone=Asia/Shanghai&useSSL=false
      host: my-mariadb.middleware
      port: 3306
      username: root
      password: N2XRLTsJ2t
      keep-alive: true
      initial-size: 10
      max-active: 100
      max-wait: 500
      time-between-eviction-runs-millis: 60000
      max-evictable-idle-time-millis: 1800001
      min-evictable-idle-time-millis: 160000
      test-while-idle: true
      test-on-borrow: true
      test-on-return: false
      pool-prepared-statements: true
      max-pool-prepared-statement-per-connection-size: 10
      validation-query: select 1
  redis:
    database: 0
    host: 172.17.0.1
    port: 6379
    password: wKffDkYpwS
    timeout: 500

jwt:
  header: Authorization
  token-start-with: Bearer
  base64-secret: ZmQ0ZGI5NjQ0MDQwY2I4MjMxY2Y3ZmI3MjdhN2ZmMjNhODViOTg1ZGE0NTBjMGM4NDA5NzYxMjdjOWMwYWRmZTBlZjlhNGY3ZTg4Y2U3YTE1ODVkZDU5Y2Y3OGYwZWE1NzUzNWQ2YjFjZDc0NGMxZWU2MmQ3MjY1NzJmNTE0MzI=
  token-validity-in-seconds: 86400000
  online-key: online-token-
  code-key: code-key

rsa:
  privateKey: MIIBUwIBADANBgkqhkiG9w0BAQEFAASCAT0wggE5AgEAAkEA0vfvyTdGJkdbHkB8mp0f3FE0GYP3AYPaJF7jUd1M0XxFSE2ceK3k2kw20YvQ09NJKk+OMjWQl9WitG9pB6tSCQIDAQABAkA2SimBrWC2/wvauBuYqjCFwLvYiRYqZKThUS3MZlebXJiLB+Ue/gUifAAKIg1avttUZsHBHrop4qfJCwAI0+YRAiEA+W3NK/RaXtnRqmoUUkb59zsZUBLpvZgQPfj1MhyHDz0CIQDYhsAhPJ3mgS64NbUZmGWuuNKp5coY2GIj/zYDMJp6vQIgUueLFXv/eZ1ekgz2Oi67MNCk5jeTF2BurZqNLR3MSmUCIFT3Q6uHMtsB9Eha4u7hS31tj1UWE+D+ADzp59MGnoftAiBeHT7gDMuqeJHPL4b+kC+gzV4FGTfhR9q3tTbklZkD2A==
  publicKey: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANL378k3RiZHWx5AfJqdH9xRNBmD9wGD2iRe41HdTNF8RUhNnHit5NpMNtGL0NPTSSpPjjI1kJfVorRvaQerUgkCAwEAAQ==

shiro:
  cipher-key: f/SY5TIve5WWzT4aQlABJA==
  cookie:
    name: rememberMe
    max-age: 604800
    redis-key-prefix: online-user-info-

login:
  tianshu:
    key:
      private: MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAIwWitG2Ia2fjqlZDy0VmGq4gtWrbvn9KqFuwut6E83JRbfAA4gkXQs7PTAEbhazSu3kCF0rDg-kmdQaqad9s2VleBAfvDk5wichHcPqoo9rK_zJcluBWJ9ftc9h5uLThbzumnbRF5eR9tznADLN0o4Wv7PMLWXoaqlamQme8uyfAgMBAAECgYB08nCrR8fvwO8A8ydXNNsL5MLci4RW0AGhyOySVlRoDCnWj0ajhe_i625WQqyA6OaZmC9fUA0qA_ijeCq_d5GlygPkQWLaUH0x23DvMUaLDNCcgcDsmdk4i3A2euwkzjN0iv3IHAwujUG8DsHr8ply-BVbdPVJVzWKnYc8xWbNyQJBANmabjDUS5wrJU-k7IlMpKXB5siYvBttc3BqAzbSVYFTGuLqioE6GXMH-x7mv9fs1RKVTXGhhjsSZvMYymggGrsCQQCkzpjkT9ky7TpUb-8ZBonruVqHCnib8wyoBlFGYU4b7F4fDEUdBAXDG8bZ1o2KTbRUeNfLCK76pQMTnAe8QXFtAkEAj3Xv5cNg4eHUJHD__PkJp7pxc5i2k4KSU--glNkQxEVM-YNVsyLhumPtnI7Wtf2O8ER8nUi3XWSheO3EK-fWlwJAecM6KtTjwECNK_1XRcIS_FoBjGwsF-xGmY2xVrJlpzPHhmDmXz2tlC1diWx_PoOSjCaMKLHNtdlcoIxTGr-vMQJARXzVwOESYHa23RQVoiFGbfTfWpyJoEQuQqkgRPNn1FGMDvpzWJiFy6uOSVddwkbKIrJCQg1Gcla6NDaiExyEvA
    salt: abcdefg
    code:
      timeout: 3600000

jasypt:
  encryptor:
    password: 4tr=Kl34jDs@O/u4_#2c

aliyun:
  access-key-id: XXXXXXXX
  access-key-secret: XXXXXXXX
  master-key-value: ZJLAB
  sms-magic-key: ZJVIS2022
  sms-white-list-phone-numbers: 18800000000,18700000000

logging:
  level:
    org.zjvis.datascience.service.mapper: WARN
    org.docx4j: WARN
    springfox.documentation.spring.web.readers.operation.CachingOperationNameGenerator: WARN
  config: classpath:logback-spring-prod.xml

swagger:
  push:
    enable: false

mybatis:
  mapper-locations: classpath*:mapper/*.xml
  type-aliases-package: org.zjvis.datascience.common.dto
  configuration:
    map-underscore-to-camel-case: true
  type-handlers-package: org.zjvis.datascience.common.handler

pagehelper:
  helperDialect: mysql
  reasonable: true
  supportMethodsArguments: true
  params: count=countSql
  returnPageInfo: check

postgres:
  port: 5432
  host: 172.17.0.1
  driver: org.postgresql.Driver
  username: postgres
  password: UbGJR1ymQC
  database: aiworks
  pool:
    init-size: 20
    max-active: 300
    min-idle: 10
    max-wait-time: 30000
    retry: 3

minio:
  url: "http://172.17.0.1:9000"
  secret: "admin"
  password: "Qc8ydPvzq2"
  bucket-size: 100MB

Jlab:
  homeDir: /root/flask/aiworks-py/common/
  notebookDir: /root/jupyterlab/notebooks/
  initLab: init_container.sh
  loadData: load_data.sh
  loadView: load_view.sh
  getToken: get_token.sh
  df2db: df_to_db.sh
  urlTemp: "http://xx.xxx.xx.xxx:%d/lab/workspaces/auto/tree/%s/?token=%s"
  userName: root
  password: some-password
  port: 22
  host: xx.xxx.xx.xxx

Jhub:
  host: http://172.17.0.1:8000
  adminUser: admin
  adminPassword: "nebula@2021"
  blockSize: 2097152
```

创建容器

```bash
# 导入镜像
docker load < aiworks-backend-springboot.tar

# 运行容器
docker run -d --name aiworks-backend-springboot --restart always -p 9100:8080 -e JAVA_OPS="-server -Xmx4096m -Xms1024m" -e APPLICATION_YAML_PATH="/app/application.yaml" -v /data/nebula/backend/conf/application.yaml:/app/application.yaml insecure.docker.registry.local:80/aiworks-backend-springboot:1.0.0-C7794598
```

### installAiworksFrontend

创建持久化目录

```bash
mkdir -p /data/nebula/frontend/conf
```

创建配置文件/data/nebula/frontend/conf/default.conf

```nginx
server {
    listen       80;
    server_name  localhost;
    client_max_body_size 1000m;

    location / {
        root   /usr/share/nginx/html;
        try_files $uri $uri/ /index.html;
    }
}
```

创建容器

```bash
# 导入镜像
docker load < aiworks-frontend-vue.tar

# 运行容器
docker run -d --name aiworks-frontend-vue --restart always -p 8080:80 -v /data/nebula/frontend/conf/default.conf:/etc/nginx/conf.d/default.conf insecure.docker.registry.local:80/aiworks-frontend-vue:1.0.0-C7794598
```

### installAiworksDocs

创建持久化目录

```bash
mkdir -p /data/nebula/docs/conf
```

创建配置文件/data/nebula/docs/conf/default.conf

```nginx
server {
    listen       80;
    server_name  localhost;
    client_max_body_size 1000m;

    location / {
        root   /usr/share/nginx/html;
        try_files $uri $uri/ /index.html;
    }
}
```

创建容器

```bash
# 导入镜像
docker load < aiworks-docs-nginx.tar

# 运行容器
docker run -d --name aiworks-docs-nginx --restart always -p 8082:80 -v /data/nebula/docs/conf/default.conf:/etc/nginx/conf.d/default.conf insecure.docker.registry.local:80/aiworks-docs-nginx:1.0.0-C7794598
```

### installAiworksGraphAnalysisBackend

创建持久化目录

```bash
mkdir -p /data/nebula/graph-analysis-backend/conf/
```

创建配置文件/data/nebula/graph-analysis-backend/conf/application.yaml

```yaml
server:
  port: 8080
spring:
  application:
    name: graph-analysis
  mvc:
    async:
      request-timeout: 600000
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://172.17.0.1:3306/graph_analysis?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true&useAffectedRows=true&serverTimezone=Asia/Shanghai
      username: root
      password: N2XRLTsJ2t
      initial-size: 10
      max-active: 50
      max-wait: 5000
      time-between-eviction-runs-millis: 30000
      min-evictable-idle-time-millis: 100000
      test-while-idle: true
      test-on-borrow: true
      test-on-return: false
      pool-prepared-statements: true
      max-pool-prepared-statement-per-connection-size: 10
  sql:
    init:
      schema-locations: classpath:sql/init.sql
      mode: always
mybatis:
  mapper-locations: classpath*:mapper/*.xml
  type-aliases-package: org.zjvis.graph.analysis.service.dto
  configuration:
    map-underscore-to-camel-case: true
minio:
  http: "http://172.17.0.1:9000"
  key: "admin"
  psw: "Qc8ydPvzq2"
  bucket-size: 100MB
janusgraph:
  gremlin:
    graph: org.janusgraph.core.JanusGraphFactory
  storage:
    backend: cql
    hostname: 172.17.0.1
    port: 9042
    username: cassandra
    password: cassandra
    cql:
      keyspace: zjvis_graph_analysis_dev
  cache:
    db-cache: true
    db-cache-clean-wait: 20
    db-cache-time: 180000
    db-cache-size: 0.25
  query:
    batch: true
    batch-property-prefetch: true
restful:
  dataScienceServer:
    address: http://172.17.0.1:9100
plugin:
  route: /graph-analysis
```

创建容器

```bash
# 导入镜像
docker load < aiworks-graph-analysis-backend-springboot.tar

# 运行容器
docker run -d --name aiworks-graph-analysis-backend-springboot --restart always -p 9101:8080 -e JAVA_OPS="-server -Xmx4096m -Xms1024m" -e APPLICATION_YAML_PATH="/app/application.yaml" -v /data/nebula/graph-analysis-backend/conf/application.yaml:/app/application.yaml insecure.docker.registry.local:80/aiworks-graph-analysis-backend-springboot:1.0.0-C7794598
```

测试是否部署成功

```bash
http://ip:9101/plugin/checkHealth
```

### installAiworksGraphAnalysisFrontend

创建持久化目录

```bash
mkdir -p /data/nebula/graph-analysis-frontend/conf
```

创建配置文件/data/nebula/graph-analysis-frontend/conf/default.conf

```nginx
server {
    listen       80;
    server_name  localhost;
    client_max_body_size 1000m;

    location / {
        root   /usr/share/nginx/html;
        try_files $uri $uri/ /index.html;
    }
}
```

创建容器

```bash
# 导入镜像
docker load < aiworks-graph-analysis-frontend-vue.tar

# 运行容器
docker run -d --name aiworks-graph-analysis-frontend-vue --restart always -p 8083:80  -v /data/nebula/graph-analysis-frontend/conf/default.conf:/etc/nginx/conf.d/default.conf insecure.docker.registry.local:80/aiworks-graph-analysis-frontend-vue:1.0.0-C7794598
```

## Nginx安装

### installNginx

> 注意：请提前在机器中安装好Nginx并启动

创建配置文件/etc/nginx/conf.d/default.conf

```nginx
upstream jupyterhub {
    server 172.17.0.1:8000;
    ip_hash;
}

upstream minio {
    server 172.17.0.1:9000;
    ip_hash;
}

upstream nebula-algo {
    server 172.17.0.1:5000;
    ip_hash;
}

upstream nebula-backend {
    server 172.17.0.1:9100;
    ip_hash;
}

upstream nebula-frontend {
    server 172.17.0.1:8080;
    ip_hash;
}

upstream nebula-docs {
    server 172.17.0.1:8082;
    ip_hash;
}

upstream nebula-graph-analysis-backend {
    server 172.17.0.1:9101;
    ip_hash;
}

upstream nebula-graph-analysis-frontend {
    server 172.17.0.1:8083;
    ip_hash;
}

server {
    listen       80;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location /jupyterhub/ {
        proxy_pass http://jupyterhub/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /minio/ {
        proxy_pass http://minio/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /nebula-algo/ {
        proxy_pass http://nebula-algo/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /api/ {
        proxy_pass http://nebula-backend/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /graph-analysis/api/ {
        proxy_pass http://nebula-graph-analysis-backend/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /graph-analysis/ {
        proxy_pass http://nebula-graph-analysis-frontend/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /docs/ {
        proxy_pass http://nebula-docs/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location / {
        proxy_pass http://nebula-frontend/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # redirect server error pages to the static page /50x.html
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

```

加载配置

```bash
nginx -t && nginx -s reload
```

## 验证服务可用性

使用浏览器访问地址http://ip，出现登录页面，账号密码：test-nebula/nebula@2021

其他相关地址如下：

- 用户手册：http://ip/docs/
- 社区：http://ip/management/plugin/list

