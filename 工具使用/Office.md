# Microsoft Office 2013激活

## 使用kms命令激活Microsoft Office 2013

1.以管理员权限进入cmd。win7系统打开开始菜单，底部搜索cmd，右键管理员打开，win8.1/win10则右键开始图标，选择命令提示符(管理员)或Windows PowerShell(管理员)。

2.进入offce安装位置，默认是安装在C:\Program Files (x86)\Microsoft Office\Office15或C:\Program Files\Microsoft Office\Office15。

3.安装Office2013激活密钥。
```
cscript ospp.vbs /inpkey:YC7DK-G2NP3-2QQC3-J6H88-GVGXT
```

4.设置kms服务器(这里使用的代理服务器为kms.03k.org，若代理服务器失效，请自行搜索“kms服务器”)
```
cscript ospp.vbs /sethst:kms.03k.org
```

5.激活Office2013
```
cscript ospp.vbs /act
```

6.查看office2013激活状态。
```
cscript ospp.vbs /dstatus
```

7.最后打开任意的Office2013，比如word，点击文件—帐户，显示激活的产品，表示激活成功。
