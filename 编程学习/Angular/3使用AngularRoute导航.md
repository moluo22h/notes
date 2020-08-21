## 路由内容介绍
## 路由基础

路由对象
| 名称 | 简介 |
| ------ | ------ |
| Routes | 路由配置，保存着组件对应的URL，以及组件要展示的RouterOutlet |
| RouterOutlet | 在Html中的占位符标签，标记了路由位置的展示位置 |
| Router | 通过Router的navigate()和navigaterByUrl()方法实现导航到某个路由组件（控制器中使用） |
| RouterLink | 通过RouterLink指定要导航到的路由组件（模板中使用） |
| ActivatedRoute | 当前激活的路由对象，保存着路由信息，如路由地址、路由参数 |

Routes对象存在于模块中，具有以下属性
- path: 浏览器URL
- component:URL对应的地址

示例：
```typeScript
const routes: Routes = [
  // 普通路由
  {path: '', component: HomeComponent},
  // 普通路由
  {path: 'product', component: ProductComponent},
  // 路由重定向
  {path: 'prod', redirectTo: '/product', pathMatch: 'full'},
  // 通配符路由。需要放到路由的最后，当路由不存在时将导航到该路由指定的组件。
  {path: '**', component: Code404Component}
];
```
>注意：path不能以 "/" 开头哦。"/"应该写在routerLink中，详情请见RouterLink对象

RouterOutlet
RouterOutlet使用在HTML模板中，用于指定组件在页面上展示的位置。RouterOutlet在哪，路由URL对应的组件就会显示在RouterOutlet标签的下方。
```html
<router-outlet></router-outlet>
```

routerLink
routerLink使用在模板的标签中，可为一个标签添加导航，常使用于<a>标签中。routerLink的值为数组类型，数组的第一个元素为路由URL，第二个元素为路由传递时携带的参数（可选）
```html
<a [routerLink]="['/']">主页</a>
<a [routerLink]="['/product']">商品详情</a>
<a [routerLink]="['/product']" [queryParams]="{id:1}">带参路由</a>
```
> 提示：当路由URL以"/"开头，表示该路由为根路由；以"./"开头，表示该路由为子路由。

Router
Router使用在控制器中，用于导航到指定路由。常使用的方法为navigate()和navigaterByUrl()方法。
```typescript
  constructor(private router: Router) {
  }

  onclick() {
    this.router.navigate(['/']);
  }
```

ActivatedRoute


新建路由
路由其实是一个特殊的模块
实战：为app模块创建一个名称为app-routing的路由
1.在app模块中新建app-routing.module.ts

```cmd
ng g module app-routing
ng g module 路由名
```
2.app-routing.module.ts内容如下

```typescript
const routes: Routes = [
  {path: '', component: HomeComponent},
  {path: 'product', component: ProductComponent}
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [RouterModule],
  declarations: []
})
export class AppRoutingModule {
}
```
3.在app模块中引入app-routing模块

```typescript
@NgModule({
  imports: [
    AppRoutingModule
  ]
})
```

新建带路由的项目
```
ng new router --routing
ng new 项目名 --routing
```
--routing 参数的作用：生成一个app-routing.module.ts路由模块并将其添加到项目根模块的依赖模块中。

```TypeScript
const routes:Routes={
   //注意path没有/哦 {prth:'',component:HomeComponent},
   {path:'**',component:Code404Component}
    
}
constructor（private router:Router）{
    
}




```


```Html
//注意有/哦 根路由 参数是一个数组
<a [routeLink]="['/']">主页</a>
./子路由



<route-outlet></route-outlet>
```



## 重定向路由
```TypeScript
{path:'',redirectTo:'/home',pathMatch:'full'}
```

## 子路由
路由的父子关系。
```typescript
{
    path: 'product/:id', component: ProductComponent, children: [
      {path: '', component: ProductDescComponent},
      {path: 'seller/:id', component: SellerInfoComponent}
    ]
}

{
    path: 'product/:id', component: ProductComponent, children: [
      {子路由一},
      {子路由二}
    ]
}
```
>注意：使用子路由时，需要使用 "./" 格式。如下<a [routerLink]="['./seller',8]">销售员信息</a>

## 辅助路由
路由的兄弟关系。可以存在多个辅助路由

辅助路由的配置
```typeScript
  // 普通路由
  {path: '', component: HomeComponent},
  // 辅助路由
  {path: 'chat', component: ChatComponent, outlet: 'aux'}
  {path: 'chat', component: ChatComponent, outlet: '辅助路由名称'}
```

辅助路由显示位置
```html
<!--主路由-->
<router-outlet></router-outlet>
<!--名为aux的辅助路由-->
<router-outlet name="aux"></router-outlet>
<router-outlet name="辅助路由名称"></router-outlet>
```

辅助路由导航
```Html
<a [routerLink]="[{outlets:{aux:'chat'}}]">开始聊天</a>
<a [routerLink]="[{outlets:{aux:null}}]">结束聊天</a>
<a [routerLink]="[{outlets:{辅助路由名称:'辅助路由URL'}}]">开始聊天</a>
```
>注意：辅助路由不带 "/" 。
扩展：一个便签控制两个路由
```Html
<a [routerLink]="[{outlets:{primary:'home',aux:'chat'}}]">开始聊天</a>
<a [routerLink]="[{outlets:{primary:'主路由URL',辅助路由名称:'辅助路由URL'}}]">开始聊天</a>
```

