## 参考

[windows下Nodejs多版本切换](https://segmentfault.com/a/1190000019597024)

## 使用淘宝镜像

1. 查看npm的镜像源

   ```bash
   npm config get registry
   // 默认是：https://registry.npmjs.org/
   // http://repo.inspur.com/artifactory/api/npm/iop-npm-virtual/
   ```

2. 修改成淘宝的镜像源

   ```bash
   npm config set registry https://registry.npm.taobao.org
   ```

3. create-react-app创建项目

   ```bash
   npx create-react-app myapp
   ```

   