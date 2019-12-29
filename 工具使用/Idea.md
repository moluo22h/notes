# idea使用

## idea搜索功能

| 快捷键              | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| Ctrl+N              | 按名字搜索类，输入类名可以定位到这个类文件                   |
| Ctrl+Shift+N        | 按文件名搜索文件，匹配所有类型的文件                         |
| Ctrl+H              | 查看类的继承关系                                             |
| Ctrl+Alt+B          | 查看子类方法实现                                             |
| Alt+F7              | 查找类或方法在哪被使用                                       |
| Ctrl+F/Ctrl+Shift+F | 按照文本的内容查找。其中Ctrl+F是在本页查找，Ctrl+Shift+F是全局查找 |
| Shift+Shift         | 搜索任何東西                                                 |

参考[intellij idea 怎么全局搜索](https://jingyan.baidu.com/article/29697b9163ac7dab20de3cbf.html)

## 跳转到接口实现类快捷键

ctrl+alt+B
## 创建类时自动生成author和date
在File and Code Tempplaes -> Includes -> File Header中添加
```java
/**
 * @author ${USER}
 * @date ${DATE}
 */
```
## 光标变成小黑块
- 笔记本：是 INS 键( Insert )
- Mac 电脑：是 fn + Enter 组合键切换输入模式。
- 如果上述方法还是不能解决问题，打开 setting -> Plugins ->搜索 ideaVim 去掉插件后面的勾 -> apply -> ok

## 代码块生成快捷键
ctrl+j
示例：生成main方法，输入“m”，按下ctrl+j

## 书签
快捷键：ctrl+shift+F11添加默认书签或ctrl+F11添加书签
书签跳转：在favorites侧边工具中进行跳转

## idea file->new 没有Java 或Java文件不识别
- [IntelliJ IDEA 中 右键新建时，选项没有Java class的解决方法和具体解释 - CSDN博客](https://blog.csdn.net/qq_27093465/article/details/52912444)
- 以上操作实际上是改变了根目录下的*.iml 文件，故直接编辑*.iml文件也是可以的
[Intellij IDEA maven Maven Web | 基于实例代码分步讲解 一站式学习Java | how2j.cn](http://how2j.cn/k/idea/idea-maven-web/1356.html#step5772)
- 解决方法三：出现问题的文件夹右键->Make Directory As->Resources Root

## 配置Java web项目 No artifacts configured
解决方法：[【错误解决】Intellj（IDEA） warning no artifacts configured](https://blog.csdn.net/small_mouse0/article/details/77506060)

## 配置spring mvc项目 unmapped spring configuration files found
解决方法：http://www.cnblogs.com/Leo_wl/p/5069135.html

## 运行Java测试类时报Command line is too long. Shorten command line for $classname.
解决方法：https://blog.csdn.net/manyu_java/article/details/78993294

## pull失败问题
解决方法：https://blog.csdn.net/qq_33039699/article/details/82866785

## IDEA乱码之编码转换

reload是关掉当前文件，重新以你要的格式打开文件例如（utf-8），文件无损
convert是直接转换你当前的文件编码，如果没备份，又没有转换成功，你会有损失的 

## SSL peer shut down incorrectly

编译时出现如下问题 `SSL peer shut down incorrectly` 或者某些jar包下载不下来，一般是因为墙的原因导致的。这时候我们就需要配置镜像来解决这个问题。（为了提高jar包的下载速度也可以配置）配置的方法就是在根build.gradle中添加镜像仓库，一般我们选择阿里的 `http://maven.aliyun.com/nexus/content/groups/public/`完整的如下所示

```groovy
plugins {
    id 'org.springframework.boot' version '2.1.5.RELEASE'
    id 'java'
}

apply plugin: 'io.spring.dependency-management'

group = 'com.moluo'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '1.8'

repositories {
    maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
//    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```



## idea激活码
激活服务器：http://idea.wrbugtest.tk/
```
812LFWMRSH-eyJsaWNlbnNlSWQiOiI4MTJMRldNUlNIIiwibGljZW5zZWVOYW1lIjoi5q2j54mIIOaOiOadgyIsImFzc2lnbmVlTmFtZSI6IiIsImFzc2lnbmVlRW1haWwiOiIiLCJsaWNlbnNlUmVzdHJpY3Rpb24iOiIiLCJjaGVja0NvbmN1cnJlbnRVc2UiOmZhbHNlLCJwcm9kdWN0cyI6W3siY29kZSI6IklJIiwiZmFsbGJhY2tEYXRlIjoiMjAxOS0wNC0yMSIsInBhaWRVcFRvIjoiMjAyMC0wNC0yMCJ9LHsiY29kZSI6IkFDIiwiZmFsbGJhY2tEYXRlIjoiMjAxOS0wNC0yMSIsInBhaWRVcFRvIjoiMjAyMC0wNC0yMCJ9LHsiY29kZSI6IkRQTiIsImZhbGxiYWNrRGF0ZSI6IjIwMTktMDQtMjEiLCJwYWlkVXBUbyI6IjIwMjAtMDQtMjAifSx7ImNvZGUiOiJQUyIsImZhbGxiYWNrRGF0ZSI6IjIwMTktMDQtMjEiLCJwYWlkVXBUbyI6IjIwMjAtMDQtMjAifSx7ImNvZGUiOiJHTyIsImZhbGxiYWNrRGF0ZSI6IjIwMTktMDQtMjEiLCJwYWlkVXBUbyI6IjIwMjAtMDQtMjAifSx7ImNvZGUiOiJETSIsImZhbGxiYWNrRGF0ZSI6IjIwMTktMDQtMjEiLCJwYWlkVXBUbyI6IjIwMjAtMDQtMjAifSx7ImNvZGUiOiJDTCIsImZhbGxiYWNrRGF0ZSI6IjIwMTktMDQtMjEiLCJwYWlkVXBUbyI6IjIwMjAtMDQtMjAifSx7ImNvZGUiOiJSUzAiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiUkMiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiUkQiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiUEMiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiUk0iLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiV1MiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiREIiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiREMiLCJmYWxsYmFja0RhdGUiOiIyMDE5LTA0LTIxIiwicGFpZFVwVG8iOiIyMDIwLTA0LTIwIn0seyJjb2RlIjoiUlNVIiwiZmFsbGJhY2tEYXRlIjoiMjAxOS0wNC0yMSIsInBhaWRVcFRvIjoiMjAyMC0wNC0yMCJ9XSwiaGFzaCI6IjEyNzk2ODc3LzAiLCJncmFjZVBlcmlvZERheXMiOjcsImF1dG9Qcm9sb25nYXRlZCI6ZmFsc2UsImlzQXV0b1Byb2xvbmdhdGVkIjpmYWxzZX0=-ti4tUsQISyJF/zfWxSHCr+IcYrX2w24JO5bUZCPIGKSi+IrgQ0RT2uum9n96o+Eob9Z1iQ9nUZ6FJdpEW5g0Exe6sw8fLrWMoLFhtCIvVgQxEEt+M7Z2xD0esmjP1kPKXZyc/i+NCxA2EO2Sec9uifqklBGP1L3xoENAw2QsIWBfttIe6EPWhbS8TIMMr2vF/S3HrN8To5Hj5lwD/t1GHgFK1uWrhsuifAiKcVzqogybzGiR1h2+yNYTMbKxP7uPCcdYMsIyrBNVRGA3IuEJgyGQTQlFbnVQoVUTGPW2tQxprmC464wMjKi40JHh27WzjOHPwgzxDaigwn4Z0EbSpA==-MIIElTCCAn2gAwIBAgIBCTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBMB4XDTE4MTEwMTEyMjk0NloXDTIwMTEwMjEyMjk0NlowaDELMAkGA1UEBhMCQ1oxDjAMBgNVBAgMBU51c2xlMQ8wDQYDVQQHDAZQcmFndWUxGTAXBgNVBAoMEEpldEJyYWlucyBzLnIuby4xHTAbBgNVBAMMFHByb2QzeS1mcm9tLTIwMTgxMTAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxcQkq+zdxlR2mmRYBPzGbUNdMN6OaXiXzxIWtMEkrJMO/5oUfQJbLLuMSMK0QHFmaI37WShyxZcfRCidwXjot4zmNBKnlyHodDij/78TmVqFl8nOeD5+07B8VEaIu7c3E1N+e1doC6wht4I4+IEmtsPAdoaj5WCQVQbrI8KeT8M9VcBIWX7fD0fhexfg3ZRt0xqwMcXGNp3DdJHiO0rCdU+Itv7EmtnSVq9jBG1usMSFvMowR25mju2JcPFp1+I4ZI+FqgR8gyG8oiNDyNEoAbsR3lOpI7grUYSvkB/xVy/VoklPCK2h0f0GJxFjnye8NT1PAywoyl7RmiAVRE/EKwIDAQABo4GZMIGWMAkGA1UdEwQCMAAwHQYDVR0OBBYEFGEpG9oZGcfLMGNBkY7SgHiMGgTcMEgGA1UdIwRBMD+AFKOetkhnQhI2Qb1t4Lm0oFKLl/GzoRykGjAYMRYwFAYDVQQDDA1KZXRQcm9maWxlIENBggkA0myxg7KDeeEwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMA0GCSqGSIb3DQEBCwUAA4ICAQAF8uc+YJOHHwOFcPzmbjcxNDuGoOUIP+2h1R75Lecswb7ru2LWWSUMtXVKQzChLNPn/72W0k+oI056tgiwuG7M49LXp4zQVlQnFmWU1wwGvVhq5R63Rpjx1zjGUhcXgayu7+9zMUW596Lbomsg8qVve6euqsrFicYkIIuUu4zYPndJwfe0YkS5nY72SHnNdbPhEnN8wcB2Kz+OIG0lih3yz5EqFhld03bGp222ZQCIghCTVL6QBNadGsiN/lWLl4JdR3lJkZzlpFdiHijoVRdWeSWqM4y0t23c92HXKrgppoSV18XMxrWVdoSM3nuMHwxGhFyde05OdDtLpCv+jlWf5REAHHA201pAU6bJSZINyHDUTB+Beo28rRXSwSh3OUIvYwKNVeoBY+KwOJ7WnuTCUq1meE6GkKc4D/cXmgpOyW/1SmBz3XjVIi/zprZ0zf3qH5mkphtg6ksjKgKjmx1cXfZAAX6wcDBNaCL+Ortep1Dh8xDUbqbBVNBL4jbiL3i3xsfNiyJgaZ5sX7i8tmStEpLbPwvHcByuf59qJhV/bZOl8KqJBETCDJcY6O2aqhTUy+9x93ThKs1GKrRPePrWPluud7ttlgtRveit/pcBrnQcXOl1rHq7ByB8CFAxNotRUYL9IF5n3wJOgkPojMy6jetQA5Ogc8Sm7RG6vg1yow==
```

## idea激活服务器搭建

本方法仅支持linux系列的操作系统：Debian、Ubuntu、CentOS，**不支持WINDOWS系统**。
一键搭建代码：

```
wget --no-check-certificate -O jetbrains.sh https://mengniuge.com/download/shell/jetbrains.sh && chmod +x jetbrains.sh && bash jetbrains.sh
```

   程序运行后，将开启1027激活端口，如果开启了防火墙，则需要放行1027端口。在JetBrains的软件激活过程中， 选择License server，填写http://你的IP:1027即可。其中的IP是你服务器的IP。

> 注意：本方法无法激活2018.2以上版本的JetBrains



博客： https://www.jiweichengzhu.com/article/a45902a1d7284c6291fe32a4a199e65c 

