# Gradle
* GroupId
* ArtifactId
* Version

#3 gradle项目目录结构
```
src
      -main
              -java
              -resources
build.gradle
settings.gradle
```

build.gradle文件
```groovy
plugins {//插件
    id 'java'
}

group 'com.moluo.boy'
version '1.0-SNAPSHOT'

sourceCompatibility = 1.8

buildscript {
    ext {
        springBootVersion = '2.1.0.RELEASE'
    }
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
    }
}

repositories {  //仓库
    mavenLocal()//本地的Maven仓库
    mavenCentral()//中心Maven仓库
    maven{//私服仓库
    url
    }
}

dependencies {//依赖
    testCompile group: 'junit', name: 'junit', version: '4.12'//编译阶段依赖
    testRuntime//运行阶段依赖
    compile()//编译时依赖{
    exclude group:"",module:;//排除依赖
    }
}

//闭包
def createDir={
    path->
        File dir=new File(path)
        if(!dir.exists()){
            dir.mkdirs()
        }
}

//任务
task makeJavaDir(){
//    dependsOn '依赖'
    def paths=['src/main/java','src/main/resources','src/test/java','src/test/resources']
    doFirst{//自定义动作
        paths.forEach(createDir)
    }
}

configurations.all{
//修改策略
resolutionStrategy{
failONversionConflict()
force group:name:version//强制指定版本
}
}

```
setting.gradle文件
```groovy
rootProject.name = 'boy.body'//和maven中的artifact一样
```

## 仓库
mavenLocal/mavenCentral/jcenter

各版本Gradle下载地址
[Gradle Distributions](http://services.gradle.org/distributions/)

## Gradle修改本地仓库的位置

设置环境变量GRADLE_USER_HOME的路径，就可改变gradle的缓存目录

参考：[Gradle修改本地仓库的位置](https://blog.csdn.net/baiyicanggou_wujie/article/details/80319377)

## gradle更换源

#### a). 配置只在当前项目生效

在 build.gradle 文件内修改/添加 repositories 配置

```groovy
repositories {
    maven {
        url "http://maven.aliyun.com/nexus/content/groups/public"
    }
}
```

#### b). 配置全局生效

找到 (用户家目录)/.gradle/init.gradle 文件，如果找不到 init.gradle 文件，自己新建一个

修改/添加 init.gradle 文件内的 repositories 配置

```groovy
allprojects {
    repositories {
        maven {
            url "http://maven.aliyun.com/nexus/content/groups/public"
        }
    }
}
```

https://www.cnblogs.com/huiyi0521/p/10997152.html

