# Gradle

## gradle plugin未发现
更换gradle版本   [gradle下载地址](http://services.gradle.org/distributions/)
> 为了防止导入项目时gradle版本不合适，导入项目时推荐使用gradle wrapper方式

## 设置Gradle的本地仓库路径

gradle的默认仓库路径为用户目录下的.gradle目录，gradle并没有像maven那样提供配置文件，若要修改默认仓库路径，我们可以设置环境变量GRADLE_USER_HOME

## 手动下载gradle

到  [gradle下载地址](http://services.gradle.org/distributions/)下载gradle之后，放到GRADLE_USER_HOME\\.gradle\wrapper\dists下解压

