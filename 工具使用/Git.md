# Git的使用

## Clone带有Submodule的仓库

切换到项目根目录下

```bash
cd example-project
```

拉取submodule

```bash
git submodule init
git submodule update
```

更多信息请查看[Git Submodule使用完整教程](https://www.cnblogs.com/lsgxeva/p/8540758.html)

##  .gitignore文件
- [官方gitignore文件](https://github.com/github/gitignore)
- idea默认生成的.gitignore文件
```
.gradle
/build/
!gradle/wrapper/gradle-wrapper.jar

### STS ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache

### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr
/out/

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
```

