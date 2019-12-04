## SSL peer shut down incorrectly

编译时出现如下问题 `SSL peer shut down incorrectly` 或者某些jar包下载不下来，一般是因为墙的原因导致的。这时候我们就需要配置镜像来解决这个问题。（为了提高jar包的下载速度也可以配置）配置的方法就是在根build.gradle中添加镜像仓库，一般我们选择阿里的 `http://maven.aliyun.com/nexus/content/groups/public/`完整的如下所示

```java
buildscript {

    repositories {
        google()
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.2.1'
    }
}

allprojects {
    repositories {
        google()
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        jcenter()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

> 这里需要注意要将jcenter放到最后一个，因为他就是那个下载慢，或者报错的罪魁祸首