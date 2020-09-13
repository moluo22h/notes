# windows激活

## 使用kms永久命令激活Windows10专业版
1.以管理员权限进入cmd。win7系统打开开始菜单，底部搜索cmd，右键管理员打开，win8.1/win10则右键开始图标，选择命令提示符(管理员)或Windows PowerShell(管理员)。

2.安装Windows10专业版激活密钥。

```
slmgr /ipk VK7JG-NPHTM-C97JM-9MPGT-3V66T
```
3.设置kms服务器(这里使用的代理服务器为kms.xspace.in，若代理服务器失效，请自行搜索“kms服务器”)
```
slmgr /skms kms.xspace.in
```
4.激活Windows10
```
slmgr /ato
```

5.查看激活的状态
```
slmgr.vbs -xpr
```

出现的窗口中提示“计算机已永久激活”，说明激活成功，否则未激活成功。

## kms服务器

[ KMS激活Windows一键脚本 ](https://www.moerats.com/kms/)

## 开机自启动目录

C:\Users\用户名\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

