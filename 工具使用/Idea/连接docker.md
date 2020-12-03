[使用Pycharm远程连接及管理Docker](https://www.jianshu.com/p/f6e02bfc18b4)

为了使远端服务器上的Docker能与本机的Pychrm进行连接和通信，需要在远端服务器上做一些设置，允许docker能被指定IP访问。

### 开放远端连接

1. 修改配置文件
    执行命令： `vi /lib/systemd/system/docker.service`

   ```bash
   # 注释原配置
   # ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
   # 使用如下信息
   ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock
   ```


2. 重启服务
    
    ```bash
    systemctl daemon-reload && systemctl restart docker
    ```
    
3. 验证

    ```bash
    
    ```

    
