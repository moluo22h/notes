# Typora

## 方法一：修改源码

原文：[Typora 使用，不用修改时间，不用补丁-CSDN博客](https://blog.csdn.net/weixin_51755538/article/details/134966247)

第一步： 下载最新版本的[Typora安装](https://so.csdn.net/so/search?q=Typora安装&spm=1001.2101.3001.7020)

第二步： 安装完后，进入[typora](https://so.csdn.net/so/search?q=typora&spm=1001.2101.3001.7020)的安装目录下的 \resources\page-dist\static\js 目录，找到 LicenseIndex开头的文件，我这里文件名如下：

![img](https://img-blog.csdnimg.cn/direct/9dff96e44b464f49820ba9aa58281c08.png)

第三步：用文本编辑器打开该文件，搜索hasActivated="true"==e.hasActivated并将其替换为hasActivated="true"=="true"
（修改前，可将该文件备份一下，万一操作失误，可以进行恢复）

![img](https://img-blog.csdnimg.cn/direct/1c864207f20f4b3f9b0dc5a36b4a4871.png)

## 方法二：注册表

原文：[Typora安装教程 - Fear丶 - 博客园 (cnblogs.com)](https://www.cnblogs.com/BenjaminLiang/p/17879575.html)

网上Typora安装教程大致有3大类：

- 序列号
- 注册表
- 替换dll

上面三种我都试过，个人感觉使用修改**注册表**的方式最稳妥。

讲一下方法：

1. 下载typora旧版本： [Typora旧版下载](https://pan.baidu.com/s/1yc3OLC7YJdgGqZ4PYsMaTA?pwd=guew)
2. 下载完 win+R 输出入 regedit 打开注册表
   ![运行注册表](https://img2023.cnblogs.com/blog/3339932/202312/3339932-20231206145001320-1802222509.png)
3. 找到路径 \HKEY_CURRENT_USER\Software\Typora
   ![Typora注册表](https://img2023.cnblogs.com/blog/3339932/202312/3339932-20231206145221763-211148212.png)
4. 先把Typora的检测版本的权限关了 否则会打不开
   ![找到权限控制](https://img2023.cnblogs.com/blog/3339932/202312/3339932-20231206145318503-897798429.png)

![拒绝权限](https://img2023.cnblogs.com/blog/3339932/202312/3339932-20231206145341975-1884044090.png)

1. 在注册表编辑器中，双击修改IDate的值,将其改为一个未来日期。比如2099-01-01。这样就可以试用Typora到2099-01-01。
   ![img](https://img2023.cnblogs.com/blog/3339932/202312/3339932-20231206145710865-333202531.png)
2. 搞定美哉！白嫖成功~