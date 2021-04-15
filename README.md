# notes使用说明

## 如何自动生成SUMMARY.md？

使用[gitbook-plugin-summary](https://github.com/julianxhokaxhiu/gitbook-plugin-summary#readme)插件自动生成SUMMARY.md。

首先，您需要安装插件

```
$ npm i gitbook-plugin-summary --save
```

之后，您需要向`book.json`中添加插件

```
{
  "plugins": [
    "summary"
  ]
}
```

最后运行以下命令即可生成SUMMARY.md

```
$ gitbook serve
```

