# liquibase

## liquibase命令行工具的使用

### 前期准备

1. [下载liquibase命令行工具](https://github.com/liquibase/liquibase/releases/download/v4.3.5/liquibase-windows-x64-installer-4.3.5.exe)并安装liquibase，下载地址请见[liquibase releases](https://github.com/liquibase/liquibase/releases)
2. 下载mysql-connector-java.jar，并将其放置于liquibase的安装目录中

### liquibase数据库初始化

1. 进入liquibase的安装目录

2. 新建liquibase.properties

   ```properties
   driver: com.mysql.jdbc.Driver
   classpath: mysql-connector-java.jar
   url: jdbc:mysql://localhost:3306/icp_iwaf?useUnicode=true&characterEncoding=UTF-8
   username: root  
   password: 123456aB
   ```

   > 注意：操作时，请使用实际数据库信息替换liquibase.properties文件中的值

3. 运行如下命令，生成dbchangelog.xml

   ```bash
   liquibase --changeLogFile=dbchangelog.xml generateChangeLog
   ```

   查看生成的dbchangelog.xml

   ```bash
   <?xml version="1.1" encoding="UTF-8" standalone="no"?>
   <databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                      xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog https://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">
       <changeSet author="moluo (generated)" id="1622444085426-1">
           <createTable remarks="国家" tableName="geo_country">
               <column name="id" remarks="主键Id" type="VARCHAR(36)">
                   <constraints nullable="false" primaryKey="true"/>
               </column>
               <column name="country_name" remarks="国家名称" type="VARCHAR(36)">
                   <constraints nullable="false" unique="true"/>
               </column>
               <column name="country_code" remarks="国家编码" type="CHAR(2)">
                   <constraints nullable="false" unique="true"/>
               </column>
               <column name="created_time" remarks="创建时间" type="datetime">
                   <constraints nullable="false"/>
               </column>
               <column name="updated_time" remarks="更新时间" type="datetime"/>
           </createTable>
       </changeSet>
   </databaseChangeLog>
   ```

4. 若除了初始化数据库结构，还有初始化数据，请使用

   ```bash
       liquibase --changeLogFile=dbchangelog.xml --diffTypes="tables, views, columns, indexes, foreignkeys, primarykeys, uniqueconstraints, data" generateChangeLog
   ```

   查看生成的dbchangelog.xml

   ```xml
   <?xml version="1.1" encoding="UTF-8" standalone="no"?>
   <databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                      xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog https://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">
       <!--   数据库结构     -->
       <changeSet author="moluo (generated)" id="1622444085426-1">
           <createTable remarks="国家" tableName="geo_country">
               <column name="id" remarks="主键Id" type="VARCHAR(36)">
                   <constraints nullable="false" primaryKey="true"/>
               </column>
               <column name="country_name" remarks="国家名称" type="VARCHAR(36)">
                   <constraints nullable="false" unique="true"/>
               </column>
               <column name="country_code" remarks="国家编码" type="CHAR(2)">
                   <constraints nullable="false" unique="true"/>
               </column>
               <column name="created_time" remarks="创建时间" type="datetime">
                   <constraints nullable="false"/>
               </column>
               <column name="updated_time" remarks="更新时间" type="datetime"/>
           </createTable>
       </changeSet>
       <!--   数据     -->
       <changeSet author="zhaoziheng (generated)" id="1622444085426-8">
           <insert tableName="geo_country">
               <column name="id" value="00794c82-74ed-4110-bd5a-17a924807a95"/>
               <column name="country_name" value=" 卢旺达"/>
               <column name="country_code" value="RW"/>
               <column name="created_time" valueDate="2021-05-19T10:50:34"/>
               <column name="updated_time" valueDate="2021-05-19T10:50:34"/>
           </insert>
       </changeSet>
   </databaseChangeLog>
   ```

> 详细文档请见：[generateChangeLog command](https://docs.liquibase.com/commands/community/generatechangelog.html)

### liquibase数据库变更

1. 进入liquibase的安装目录

2. 新建liquibase.properties

   ```properties
   driver: com.mysql.jdbc.Driver
   classpath: mysql-connector-java.jar
   url: jdbc:mysql://localhost:3306/target_db?useUnicode=true&characterEncoding=UTF-8
   username: root
   password: 123456aB
   referenceUrl: jdbc:mysql://localhost:3306/source_db?characterEncoding=utf8
   referenceUsername: root
   referencePassword: 123456
   ```

   > 注意：操作时，请使用实际数据库信息替换liquibase.properties文件中的值

3. 运行如下命令，生成dbchangelog.xml

   ```bash
   liquibase --changeLogFile=dbchangelog.xml diffChangeLog
   ```

4. 查看生成的dbchangelog.xml

   ```bash
   <?xml version="1.1" encoding="UTF-8" standalone="no"?>
   <databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                      xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog https://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">
       <changeSet author="zhaoziheng (generated)" id="1622454528541-1">
           <addColumn tableName="site">
               <column name="is_ip_blacklist_defence" remarks="是否启用IP黑名单防护功能" type="TINYINT(3)">
                   <constraints nullable="false"/>
               </column>
           </addColumn>
       </changeSet>
       <changeSet author="zhaoziheng (generated)" id="1622454528541-2">
           <addColumn tableName="site">
               <column name="is_ip_whitelist_defence" remarks="是否启用IP白名单防护功能" type="TINYINT(3)">
                   <constraints nullable="false"/>
               </column>
           </addColumn>
       </changeSet>
       <changeSet author="zhaoziheng (generated)" id="1622454528541-3">
           <addColumn tableName="site">
               <column name="is_geo_defence" remarks="是否启用地域防护功能" type="TINYINT(3)">
                   <constraints nullable="false"/>
               </column>
           </addColumn>
       </changeSet>
   </databaseChangeLog>
   
   ```

   > 详细文档请见：[diffChangeLog command](https://docs.liquibase.com/commands/community/diffchangelog.html)

## springboot集成liquibase

添加如下依赖即可

```
implementation 'org.liquibase:liquibase-core'
```



问题： Cannot find changelog location: class path resource [db/changelog/db.changelog-master.yaml]

1. resources\db\changelog下新建文件夹changeset，该文件夹名可根据个人喜好命名

2. resources\db\changelog下新建db.changelog-master.yaml文件，文件内容如下：

   注意path的值为第一步中新建的文件夹路径

   ```yaml
   databaseChangeLog:
     - includeAll: 
         path: db/changelog/changeset
   ```

   

问题：Could not find directory or directory was empty for includeAll 'db/changelog/changeset/'

在resources\db\changelog\changeset下新建changelog文件即可。

如新建20190718-1-ddl-create_table-zzh.xml

```xml
<?xml version="1.1" encoding="UTF-8" standalone="no"?>
<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog" xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog-ext /liquibase/dbchangelog-ext.xsd http://www.liquibase.org/xml/ns/dbchangelog /liquibase/dbchangelog-3.6.xsd">
    <changeSet author="zhaoziheng (generated)" id="1563435418000-1">
        <createTable tableName="category" remarks="产品分类表">
            <column name="id" type="VARCHAR(36)" remarks="id">
                <constraints primaryKey="true"/>
            </column>
            <column name="name" type="VARCHAR(36)" remarks="产品分类名称"/>
            <column name="description" type="VARCHAR(256)" remarks="产品分类描述"/>
            <column name="modified_by" type="VARCHAR(60)" remarks="更改者"/>
            <column name="created_time" type="datetime" remarks="创建时间"/>
            <column name="updated_time" type="datetime" remarks="更新时间"/>
            <column name="deleted_time" type="datetime" remarks="删除时间"/>
            <column name="is_deleted" type="tinyint(1)" remarks="是否被软删除"/>
        </createTable>
    </changeSet>
</databaseChangeLog>
```



已有数据库迁移命令

仅迁移数据库结构

```bash
liquibase --driver=com.mysql.cj.jdbc.Driver --classpath=F:\software_install\gradle\.gradle\caches\modules-2\files-2.1\mysql\mysql-connector-java\8.0.18\e088efaa4b568bc7d9f7274b9c5ea1a00da1a45c\mysql-connector-java-8.0.18.jar --changeLogFile=E:\test\testForIdea\mo-api\src\main\resources\db\changelog\db.changelog-master.yaml --url="jdbc:mysql://127.0.0.1:3306/mo?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true" --username=root --password=123456 generateChangeLog
```

迁移数据库结构及数据

```bash
liquibase --driver=com.mysql.jdbc.Driver --classpath=mysql-connector-java.jar --changeLogFile=./dbchangelog2.xml --url="jdbc:mysql://localhost:3306/icp_iwaf?characterEncoding=utf8" --username=root --password=123456aB --diffTypes="tables, views, columns, indexes, foreignkeys, primarykeys, uniqueconstraints, data" generateChangeLog
```







