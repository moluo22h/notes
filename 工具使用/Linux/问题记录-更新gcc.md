yum -y install centos-release-scl

```bash
Error downloading packages:
  centos-release-scl-rh-2-3.el7.centos.noarch: [Errno 256] No more mirrors to try.
  centos-release-scl-2-3.el7.centos.noarch: [Errno 256] No more mirrors to try.
```









```bash
yum -y install centos-release-scl
yum -y install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils
scl enable devtoolset-9 bash
echo "source /opt/rh/devtoolset-9/enable" >>/etc/profile
source /etc/profile
```





## 参考文档

[Centos7.3修改yum源为阿里云yum源-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/786782)