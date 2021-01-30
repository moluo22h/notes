## 集成liquibase

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

```bash
liquibase --driver=com.mysql.cj.jdbc.Driver --classpath=F:\software_install\gradle\.gradle\caches\modules-2\files-2.1\mysql\mysql-connector-java\8.0.18\e088efaa4b568bc7d9f7274b9c5ea1a00da1a45c\mysql-connector-java-8.0.18.jar --changeLogFile=E:\test\testForIdea\mo-api\src\main\resources\db\changelog\db.changelog-master.yaml --url="jdbc:mysql://127.0.0.1:3306/mo?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true" --username=root --password=123456 generateChangeLog
```



