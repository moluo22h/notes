## ui整体布局

* Header
* sidebar
* Footer
* Main

## 模块功能介绍

核心模块：只加载一个的组件和服务（比如header、footer、sidebar）
共享模块：导入导出模块



## 模块间调用

Module间只能使用已导出的组件。在Module的@NgModule中加入如下：

```typescript
  exports: [
    HeaderComponent,
    FooterComponent,
    SidebarComponent
  ]
```



工具类
实体类

```ts
export interface User{
     id?: string;
     email: string;
     name?: string;
     password?: string;
     avatar?: string;
}
```



div>header+main+footer

dialog

需要在模块的entryComponent中声明



## 扩展：angular-cli命令

生成组件：ng g c {文件夹名}/{组件名} [ 参数 ]

生成组件：ng g m {文件夹名}/{模块名} [ 参数 ]

* 不生成测试代码：--spec=false

## angular：常见代码问题

报错：'app-header' is not a known element:
导出header、footer、sidebar
  exports: [
    HeaderComponent,
    FooterComponent,
    SidebarComponent
  ]





