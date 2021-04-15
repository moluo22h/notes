# notes使用说明

## 如何本地预览?

首先，您需要安装gitbook-cli

```bash
$ npm install -g gitbook-cli
```

执行`gitbook serve`来预览这本书

```bash
$ gitbook serve
```

## 如何自动生成SUMMARY.md？

使用[gitbook-summary](https://github.com/imfly/gitbook-summary)插件自动生成SUMMARY.md。

首先，您需要安装插件

```bash
$ npm install -g gitbook-summary
```

之后，您需要向`book.json`中添加插件

```json
{
    "title": "notes",
    "ignores": [
        "_book",
        "node_modules"
    ]
}
```

最后运行以下命令即可生成SUMMARY.md

```bash
$ cd /path/to/your/book/
$ book sm
```

