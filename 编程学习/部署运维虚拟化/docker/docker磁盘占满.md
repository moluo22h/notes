```bash
### shut down docker first
systemctl stop docker.socket
systemctl stop docker
 
mv /var/lib/docker /home/
ln -s /home/docker/ /var/lib/
 
### restart docker now
systemctl start docker
```

## 参考文档

[如何清理 Docker 占用的磁盘空间 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/100793598)

[Docker关闭不掉进程，Stopping docker.service, but it can still be activated by: docker.socket-CSDN博客](https://blog.csdn.net/qq_42595452/article/details/125061607)

[Docker overlay 默认位置硬盘不足，如何更换位置_docker 修改overlay2 路径-CSDN博客](https://blog.csdn.net/a314687289/article/details/112219959)