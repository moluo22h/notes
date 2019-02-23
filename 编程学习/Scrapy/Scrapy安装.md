## Scrapy国内安装方法
1.到https://www.lfd.uci.edu/~gohlke/pythonlibs/下载指定版本的Twisted
Twisted‑18.9.0‑cp36‑cp36m‑win_amd64.whl
> 格式：Twisted‑{版本号}‑cp{python版本号}‑cp{python版本号}m‑win_amd{window位数}.whl

2.安装Twisted

   ```bash
   pip install {Twisted文件目录}Twisted‑18.9.0‑cp36‑cp36m‑win_amd64.whl
   ```

3.安装Scrapy
pip install Scrapy -i https://pypi.douban.com/simple

## ModuleNotFoundError: No module named 'win32api'

需要安装 [pywin32](https://pypi.org/project/pypiwin32/#files)，下载后，使用cmd命令打开windows的命令行窗口，进入whl包所在的文件夹执行如下命令:
```bash
pip install pypiwin32-223-py3-none-any.whl
```

