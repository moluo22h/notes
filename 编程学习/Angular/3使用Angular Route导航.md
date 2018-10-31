## 路由内容介绍
视图状况

Routes 路由配置 
RouterOutlet 展示位置
Router 控制器中使用navigate() navigaterByUrl() 
RouterLink  模板上使用
ActivatedRoute


Routes
path: 
component:

RouterOutlet






ng new router --routing
--routing 
会生成一个app-routing.module.ts模块并向模块中添加依赖

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




<route-outlet></route-outlet>
```


## 在路由时传递数据
```Html
[queryParams]=”{id:1}"


```

```TypeScript
/product？id=1   ActivatedRoute.query[id]
params[id0]
data:[{idProd:true}]  .data[0].[isProd]




private routeInfo:ActivatedRoute

this.routeInfo.snapshot.queryParoms["id"]

```

修改路由page页 /：id
修改路由链接的参数"['/product',1]"
Params["id"]

参数快照，参数订阅
this.routeInfo.params.subccribe((Params:Params)=>this.productId=params["id]);


## 重定向路由
```TypeScript


{path:'',redirectTo:'/home',pathMatch:'full'}

```

## 子路由



```Ts
{path:'home',component:HomeComponent,children:[
 {path:'',component:Prod},
 {path:'seller/:id',component:sellerInfocomponent}
]
}

```


```Html
//子路由
<a [routerLink]="['./']"></a>

```

## 辅助路由
允许定义多个


```Html
[outletLink]=[{outlits:{primary:'home',aux:'chat'}}]


<router-outlet></router-outlet>

<router-outlet name="aux"></router-outlet>


```

```Ts
{path:'',component:home outlet:'aux'}


```

## 路由守卫
拥有权限才进入路由
CanActivate 导航路由
CanDeactivate 离开路由时促发
Resolve


```TypeScript

canActivate:[LoginGuard]
resolve：{
    product：ProductResolver
}

providers:[LoginGuard]

@Injectable()

```
