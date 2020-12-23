安装python包




豆瓣源： http://pypi.douban.com/simple/ 



使用镜像源很简单，用-i指定就行了： 
sudo easy_install -i http://pypi.douban.com/simple/ saltTesting 
sudo pip install -i http://pypi.douban.com/simple/ saltTesting



Linux 平台下安装方式：

```bash
sudo easy_install -i http://pypi.douban.com/simple/ ipython
sudo pip install -i http://pypi.douban.com/simple/ --trusted-host=pypi.douban.com/simple ipython
```

windows 平台下安装方式：

```bash
pip install  -i  https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com  django
```

