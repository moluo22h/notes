[三步解决error: Microsoft Visual C++ 14.0 or greater is required. Get it with “Microsoft C++ Build Tools“-CSDN博客](https://blog.csdn.net/Guangli_R/article/details/143758974)





```bash
[root@centos cube-studio]# docker build --network=host -t ccr.ccs.tencentyun.com/cube-studio/kubeflow-dashboard:base-python3.9 -f install/docker/Dockerfile-base .
[+] Building 242.4s (8/19)                                                                                                                                                                                                    docker:default
 => [internal] load build definition from Dockerfile-base                                                                                                                                                                               0.1s
 => => transferring dockerfile: 2.26kB                                                                                                                                                                                                  0.1s
 => [internal] load metadata for docker.io/library/ubuntu:22.04                                                                                                                                                                       202.9s
 => [internal] load .dockerignore                                                                                                                                                                                                       0.0s
 => => transferring context: 2B                                                                                                                                                                                                         0.0s
 => [ 1/15] FROM docker.io/library/ubuntu:22.04@sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97                                                                                                                 0.0s
 => [internal] load build context                                                                                                                                                                                                       0.0s
 => => transferring context: 509B                                                                                                                                                                                                       0.0s
 => CACHED [ 2/15] COPY install/docker/sources.list.amd64 /etc/apt/sources.list                                                                                                                                                         0.0s
 => CACHED [ 3/15] COPY install/docker/pip.conf /root/.pip/pip.conf                                                                                                                                                                     0.0s
 => ERROR [ 4/15] RUN apt-get clean all && apt-get update -y                                                                                                                                                                           39.1s
------                                                                                                                                                                                                                                       
 > [ 4/15] RUN apt-get clean all && apt-get update -y:                                                                                                                                                                                       
0.331 Get:1 http://mirrors.aliyun.com/ubuntu jammy InRelease [270 kB]                                                                                                                                                                        
0.527 Get:2 http://mirrors.aliyun.com/ubuntu jammy-security InRelease [129 kB]                                                                                                                                                               
0.735 Get:3 http://mirrors.aliyun.com/ubuntu jammy-updates InRelease [128 kB]                                                                                                                                                                
0.896 Get:4 http://mirrors.aliyun.com/ubuntu jammy-proposed InRelease [279 kB]                                                                                                                                                               
1.046 Get:5 http://mirrors.aliyun.com/ubuntu jammy-backports InRelease [127 kB]
1.256 Get:6 http://mirrors.aliyun.com/ubuntu jammy/restricted Sources [28.2 kB]
1.440 Get:7 http://mirrors.aliyun.com/ubuntu jammy/universe Sources [22.0 MB]
18.74 Get:8 http://mirrors.aliyun.com/ubuntu jammy/main Sources [1668 kB]
20.20 Get:9 http://mirrors.aliyun.com/ubuntu jammy/multiverse Sources [361 kB]
20.52 Get:10 http://mirrors.aliyun.com/ubuntu jammy/main amd64 Packages [1792 kB]
22.08 Get:11 http://mirrors.aliyun.com/ubuntu jammy/universe amd64 Packages [17.5 MB]
37.37 Get:12 http://mirrors.aliyun.com/ubuntu jammy/restricted amd64 Packages [164 kB]
37.71 Get:13 http://mirrors.aliyun.com/ubuntu jammy/multiverse amd64 Packages [266 kB]
38.21 Reading package lists...
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-security/InRelease is not valid yet (invalid for another 6h 15min 26s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-updates/InRelease is not valid yet (invalid for another 6h 17min 0s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-proposed/InRelease is not valid yet (invalid for another 6h 18min 47s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-backports/InRelease is not valid yet (invalid for another 2h 28min 19s). Updates for this repository will not be applied.
------
Dockerfile-base:14
--------------------
  12 |     COPY install/docker/sources.list.${TARGETARCH} /etc/apt/sources.list
  13 |     COPY install/docker/pip.conf /root/.pip/pip.conf
  14 | >>> RUN apt-get clean all && apt-get update -y
  15 |     
  16 |     # 安装运维工具
--------------------
ERROR: failed to solve: process "/bin/sh -c apt-get clean all && apt-get update -y" did not complete successfully: exit code: 100
```





```bash 
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-security/InRelease is not valid yet (invalid for another 6h 15min 26s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-updates/InRelease is not valid yet (invalid for another 6h 17min 0s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-proposed/InRelease is not valid yet (invalid for another 6h 18min 47s). Updates for this repository will not be applied.
38.98 E: Release file for http://mirrors.aliyun.com/ubuntu/dists/jammy-backports/InRelease is not valid yet (invalid for another 2h 28min 19s). Updates for this repository will not be applied.
```







出现这个提示说明当前你配置的阿里云 Ubuntu 软件源（`http://mirrors.aliyun.com/ubuntu/dists/jammy-security/`这个仓库对应的 `InRelease` 文件）在当前时刻被认为还没到生效时间，还需要等待约 6 小时 15 分钟 26 秒后才会被视为有效，所以暂时不会应用来自这个仓库的更新。

以下是一些可能的解决办法和原因分析：

### 原因分析

1. **时间同步问题**
   最常见的原因是系统时间不准确。系统会根据本地时间去判断软件源中发布文件（如 `InRelease` 文件）是否到了生效时间，如果本地时间与真实时间偏差较大，就容易出现这种认为其还没生效的误判情况。例如，如果你的系统时间比实际时间慢了较多，就可能出现明明软件源那边已经可以正常使用了，但按照你本地偏差后的时间来判断却是还没到生效时间的现象。
2. **软件源服务器端配置及缓存问题（相对少见）**
   有可能阿里云那边对该仓库的发布配置、缓存策略等出现了临时异常情况，导致发送给客户端（也就是你的系统）的生效时间判断出现了这样的提示，但这种情况一般比较少见，且通常会较快恢复正常，大多还是时间同步相关的问题导致的。

### 解决办法

1. **检查并同步系统时间**

   - 首先使用 `date` 命令查看当前系统显示的时间是否准确：

   ```bash
   date
   ```

   - 如果时间不准确，按照之前提到的使用 `ntpdate` 或者更推荐的 `chrony` 等工具来同步时间，确保系统时间和真实时间相符。例如使用 `chrony` 同步时间（先确保已安装 `chrony`，如果没安装通过 `sudo apt install chrony` 安装）：

   ```bash
   sudo systemctl start chrony  # 启动chrony服务（如果还没启动）
   sudo systemctl enable chrony  # 设置chrony开机自启
   sudo chronyc sources  # 查看时间同步源的状态
   ```

   等待一段时间确保时间准确同步后，再尝试更新软件仓库（执行 `sudo apt update` 命令），看是否还会出现该提示。

2. **更换软件源镜像（临时办法，可选）**
   如果时间同步后还是出现同样问题，有可能是阿里云该仓库所在的服务器节点出现了临时故障或配置异常等情况，可以考虑临时更换其他可用的 Ubuntu 软件源镜像，比如国内的清华源等，修改 `/etc/apt/sources.list` 文件，将原来指向阿里云 `jammy-updates` 相关的内容替换为清华源对应内容（以下是示例内容，将 `jammy-updates` 部分替换掉）：

```bash
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
```

修改完后保存文件，再执行 `sudo apt update` 来更新软件仓库并查看是否能正常获取更新了。不过等之后如果阿里云那边恢复正常了，你也可以再切换回阿里云源继续使用。

1. **等待一段时间后再试（如果确定不是时间同步问题）**
   如果经过排查确定不是系统时间问题，且不想更换软件源镜像，那可以等提示里的这段时间过去后，再尝试执行 `sudo apt update` 命令，看能否正常应用来自该仓库的更新，毕竟有可能只是阿里云服务器端的临时配置生效延迟等小问题导致的。

通过以上这些办法一般就能解决出现该提示无法应用软件仓库更新的问题了。