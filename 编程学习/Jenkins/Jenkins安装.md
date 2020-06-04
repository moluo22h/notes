# Jenkins安装

## war包安装

详见[官方文档](https://jenkins.io/zh/doc/pipeline/tour/getting-started/)

1. [下载 Jenkins](http://mirrors.jenkins.io/war-stable/latest/jenkins.war).
2. 打开终端进入到下载目录.
3. 运行命令 `java -jar jenkins.war --httpPort=8080`.
4. 打开浏览器进入链接 `http://localhost:8080`.
5. 按照说明完成安装.

安装完成后，您可以开始使用 Jenkins！

## docker安装

```bash
docker run \
  --rm \
  -u root \
  -p 8080:8080 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME":/home \
  jenkinsci/blueocean
```





jenkins插件安装

系统管理

rebuilder

safe restart





配置全局配置



```shell
BUILD_ID=DONTKILLME

```

