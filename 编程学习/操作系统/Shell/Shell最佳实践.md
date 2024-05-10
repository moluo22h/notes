# Shell最佳实践

```bash
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi

cd "$(dirname "$0")"

main() {
    echo do awesome stuff
}

main "$@"
```



## 参考文档

[Shell 脚本最佳实践 - 掘金 (juejin.cn)](https://juejin.cn/post/7181066295205429285)

[编写Linux Shell脚本的最佳实践 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/69470319)

[Shell 风格指南 - 内容目录 — Google 开源项目风格指南 (zh-google-styleguide.readthedocs.io)](https://zh-google-styleguide.readthedocs.io/en/latest/google-shell-styleguide/contents/)

[Bash 脚本 set 命令教程 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2017/11/bash-set.html)

[linux-shell脚本中的参数解析 - Vincent-yuan - 博客园 (cnblogs.com)](https://www.cnblogs.com/Vincent-yuan/p/16223057.html)