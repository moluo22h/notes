# Maven
## 为什么要使用Maven？
举个例子，公司要做一个web项目，作为程序员的你，第一步要做的就是各个框架的jar包下载，而这会带来什么？
* jar包太多，一个个去官网下载jar包麻烦。
* jar包有用的，没用的，版本兼容问题

为了解决以上问题，于是开源大神提出了项目管理工具：Maven、Ant、Gradle

## Maven项目的目录结构
```java
src     //源代码目录
      -main   //项目功能源代码
                  -java
                          -package      //自定义的包
      -test     //项目测试代码
                -java
                        -package
      -resource //资源目录
      pom.xml //Maven的标志文件
```
## Maven配置文件----pom.xml解析
### pom.xml模板
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/maven-4.0.0.xsd">
   <modelVersion>4.0.0</modelVersion>
   <groupId>com.domain-name.project-name</groupId>
   <artifactId>module-name</artifactId>
   <version>0.0.1-SNAPSHOT</version>
   
   <dependencies>
      <dependency>
         <groupId>junit</groupId>
         <artifactId>junit</artifactId>
         <version>3.8.1</version>
         <scope>test</scope>
      </dependency>
   </dependencies>
</project>
```
### pom.xml详解 
[史上最全的Maven Pom文件标签详解](https://www.cnblogs.com/sharpest/p/7738444.html)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <!--maven的版本-->
    <modelVersion>4.0.0</modelVersion>

    <!--项目的包名：公司网址反写+项目名-->
    <groupId>com.moluo</groupId>
    <!--模块名，建议项目名+模块名-->
    <artifactId>girl</artifactId>
    <!--项目版本：snapshot快照、release稳定、beta公测、GA正式发布-->
    <version>0.0.1-SNAPSHOT</version>

    <!--maven打包方式war、zip、pom-->
    <packaging>jar</packaging>

    <!--项目的描述名-->
    <name>girl</name>
    <!--项目描述-->
    <description>Demo project for Spring Boot</description>
    <url>项目地址</url>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
    </properties>

    <parent>
        <!--继承父模块的pom-->
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.0.3.RELEASE</version>
        <relativePath/>
    </parent>

    <dependencyManagement>
        <!--不会在项目中运行，用于给子pom依赖-->
        <dependencies>
        </dependencies>
    </dependencyManagement>

    <dependencies>
        <!--依赖的项目-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>2.0.3.RELEASE</version>
        </dependency>
    </dependencies>


    <build>
        <plugins>
            <!--Maven插件-->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

    <modules>
        <!--模块聚合,同时编译多个maven项目-->
        <module></module>
    </modules>

</project>
```
## Maven命令
* **mvn compile** //编译项目，会在项目根目录下生成target目录且编译后的class文件存放在target/classes目录下
* **mvn test**  //测试，会在target/surefire-reports目录下生成测试报告
* **mvn package** //打包，会在target目录下生成项目的jar
* **mvn clean** //删除target目录
* **mvn install** //安装jar包到本地仓库中

> Maven插件
> mvn archetype:genarate  //maven自动建立目录骨架

## Maven相关知识
### Maven是怎么找到我们需要的构件的呢？
*通过仓库+坐标*
>* 坐标
>groupId:
>artifactId:
>version:

>* 仓库
> 本地仓库和远程仓库
>镜像仓库

  为中央仓库配置镜像仓库
  maven安装目录/conf/setttings.xml

  ```xml
<mirror>
      <id>maven.net.cn  (镜像仓库的id)</id>
      <mirrorOf>central(未那个仓库配置镜像仓库)</mirrorOf>
      <name>central mirror in china</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public（镜像仓库的url）</url>
</mirror>
  ```
  更改本地仓库路径
  maven安装目录/conf/settings.xml
  <localRepository>/path/to/local/repo(本地仓库路径)</localRepository>


  ## Maven生命周期
