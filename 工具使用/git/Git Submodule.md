## Git Submodule管理项目子模块

不造重复的轮子，也不写重复的博客。

我们不是代码的创造者，但我们是代码的搬运工。

以下博客是小编多方对比、认真筛选，得出质量较高的博客，以供大家参考

本文转载自：[Git Submodule管理项目子模块](https://www.cnblogs.com/nicksheng/p/6201711.html)

## 使用场景

当项目越来越庞大之后，不可避免的要拆分成多个子模块，我们希望各个子模块有独立的版本管理，并且由专门的人去维护，这时候我们就要用到git的submodule功能。

## 常用命令

```shell
git clone <repository> --recursive 递归的方式克隆整个项目
git submodule add <repository> <path> 添加子模块
git submodule init 初始化子模块
git submodule update 更新子模块
git submodule foreach git pull 拉取所有子模块
```

## 如何使用

### 1. 创建带子模块的版本库

例如我们要创建如下结构的项目

```
project
  |--moduleA
  |--readme.txt
```

创建project版本库，并提交readme.txt文件

```shell
git init --bare project.git
git clone project.git project1
cd project1
echo "This is a project." > readme.txt
git add .
git commit -m "add readme.txt"
git push origin master
cd ..
```

创建moduleA版本库，并提交a.txt文件

```shell
git init --bare moduleA.git
git clone moduleA.git moduleA1
cd moduleA1
echo "This is a submodule." > a.txt
git add .
git commit -m "add a.txt"
git push origin master
cd ..
```

在project项目中引入子模块moduleA，并提交子模块信息

```shell
cd project1
git submodule add ../moduleA.git moduleA
git status
git diff
git add .
git commit -m "add submodule"
git push origin master
cd ..
```

使用`git status`可以看到多了两个需要提交的文件，其中`.gitmodules`指定submodule的主要信息，包括子模块的路径和地址信息，`moduleA`指定了子模块的commit id，使用`git diff`可以看到这两项的内容。这里需要指出父项目的git并不会记录submodule的文件变动，它是按照commit id指定submodule的git header，所以`.gitmodules`和`moduleA`这两项是需要提交到父项目的远程仓库的。

```
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
	new file:   .gitmodules
	new file:   moduleA
```

### 2. 克隆带子模块的版本库

方法一，先clone父项目，再初始化submodule，最后更新submodule，初始化只需要做一次，之后每次只需要直接update就可以了，需要注意submodule默认是不在任何分支上的，它指向父项目存储的submodule commit id。

```shell
git clone project.git project2
cd project2
git submodule init
git submodule update
cd ..
```

方法二，采用递归参数`--recursive`，需要注意同样submodule默认是不在任何分支上的，它指向父项目存储的submodule commit id。

```shell
git clone project.git project3 --recursive
```

### 3. 修改子模块

修改子模块之后只对子模块的版本库产生影响，对父项目的版本库不会产生任何影响，如果父项目需要用到最新的子模块代码，我们需要更新父项目中submodule commit id，默认的我们使用`git status`就可以看到父项目中submodule commit id已经改变了，我们只需要再次提交就可以了。

```shell
cd project1/moduleA
git branch
echo "This is a submodule." > b.txt
git add .
git commit -m "add b.txt"
git push origin master
cd ..
git status
git diff
git add .
git commit -m "update submodule add b.txt"
git push origin master
cd ..
```

### 4. 更新子模块

更新子模块的时候要注意子模块的分支默认不是master。

方法一，先pull父项目，然后执行`git submodule update`，注意moduleA的分支始终不是master。

```shell
cd project2
git pull
git submodule update
cd ..
```

方法二，先进入子模块，然后切换到需要的分支，这里是master分支，然后对子模块pull，这种方法会改变子模块的分支。

```shell
cd project3/moduleA
git checkout master
cd ..
git submodule foreach git pull
cd ..
```

### 5. 删除子模块

网上有好多用的是下面这种方法

```shell
git rm --cached moduleA
rm -rf moduleA
rm .gitmodules
vim .git/config
```

删除submodule相关的内容，例如下面的内容

```
[submodule "moduleA"]
      url = /Users/nick/dev/nick-doc/testGitSubmodule/moduleA.git
```

然后提交到远程服务器

```shell
git add .
git commit -m "remove submodule"
```

但是我自己本地实验的时候，发现用下面的方式也可以，服务器记录的是`.gitmodules`和`moduleA`，本地只要用git的删除命令删除moduleA，再用git status查看状态就会发现.gitmodules和moduleA这两项都已经改变了，至于.git/config，仍会记录submodule信息，但是本地使用也没发现有什么影响，如果重新从服务器克隆则.git/config中不会有submodule信息。

```shell
git rm moduleA
git status
git commit -m "remove submodule"
git push origin master
```