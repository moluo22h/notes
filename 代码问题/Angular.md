# Angular

## Can't bind to 'formControl' since it isn't a known property of 'input'
原因：未引入ReactiveFormsModule模块
解决方式：在对应模块的@ngModule注解的declarations中加入ReactiveFormsModule

##  Cannot find control with name
  原因：

  ```html
   <nz-select formControlName="productTemplateId" [(ngModel)]="productTemplateId">
  ```
  解决方法： 解决方法：在ngOnInit() {}中加入如下代码，在表单组中声明表单
  ```java
  this.validateForm = this.fb.group({
      //code: [null, [Validators.required, Validators.pattern("^[A-Za-z0-9\-]+$"), Validators.maxLength(36)]],
      productTemplateId: [Validators.required],
    });
  ```
## StaticInjectorError
  解决方法：在模块的@NgModule({})中加入服务提供者

  ```html
  providers: [
    ProductInstanceService, {provide: HTTP_INTERCEPTORS, useClass: HttpInterceptorService, multi: true},
    ProductInstancePropService, {provide: HTTP_INTERCEPTORS, useClass: HttpInterceptorService, multi: true}
  ]
  ```

## Could not find module "@angular-devkit/build-angular"
解决方法：npm i --save-dev @angular-devkit/build-angular

## Cannot read property 'all' of undefined
解决方法一:初始化相关数据
解决方法二：使用"？."来取数据，而不直接用"."

## 随机文字

lorem+tab

## 'app-navbar' is not a known element:

解决步骤：

1. 检查app-navbar组件是否被其组件导出，导出

   ```typescript
   @NgModule({
     declarations: [
       NavbarComponent,
       FooterComponent
     ],
     imports: [
       CommonModule
     ],
     exports:[
       NavbarComponent,
       FooterComponent
     ]
   })
   ```
2. 检出使用app-navbar组件的模块是否导入app-navbar组件所处的模块

## has been blocked by CORS policy

使用代理

proxy.conf.json

```json
{
  "/user/**": {
    "target": "http://localhost:9000",
    "secure": false
  }
}
```

package.json

```json
"start":"ng serve --proxy-config proxy.conf.json"
```
