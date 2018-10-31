# Angular

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


