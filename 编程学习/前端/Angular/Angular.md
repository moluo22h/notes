# Angular
npm install的作用
根据package.json下载依赖包,生成nodeModul

自动AOT
--prod --aot

ng build --prod --aot 
生成dist

ng test
测试用例  spec
前端自动话测试

STUQ

* 添加依赖
  在package.json文件中"dependencies": {}中添加"ng-zorro-antd": "^1.4.1",

* 样式文件添加
  angular.json文件下搜索style（2处），在 "styles": []中添加样式文件    "node_modules/ng-zorro-antd/src/ng-zorro-antd.min.css",
  ```java
  "styles": [
  	"node_modules/ng-zorro-antd/src/ng-zorro-antd.min.css",
  	"src/styles.css"
  ],
  ```
* 在工程中引入第三方模块
   在根模块app.module.ts中imports:[]中加入NgZorroAntdModule

 * 子模块加载子子模块路由
 * 模块service
   * 模块中注册服务，在@NgModule（{}）中加入
   ```java
   providers: [ProductInstanceService, {provide: HTTP_INTERCEPTORS, useClass: HttpInterceptorService, multi: true},]
   ```
   * 设置请求头
    ```java
    const httpOptions = {
      headers: new HttpHeaders({'Content-Type': 'application/json'})
    };
    ```
    * 依赖注入
    ```
      constructor(private http: HttpClient, private errorService: ErrorService) {}
    ```
    * 错误处理
    ```
     private handleError() {
    return (error: any): Observable<any> => {
      this.errorService.error(error);
      return observableThrowError(error);
    };
    }
    ```
    * 获取后台api示例
    ```
      getEndpointDatas(environmentId): Observable<any> {
    return this.http.get("/hub/owner/" + environmentId).pipe(
      tap(response => response),
      catchError(this.handleError())
    );
    }
    ```
  * angular方向代理配置
      1. 在项目根目录下新增一个文件保存代理的配置(proxy.conf.json)
      ```
      {
        "/": {
          "target": "http://localhost:5000",
          "secure": false,
          "changeOrigin": true
        }
      }
      ```
      2. 修改 package.json 文件中scripts下start命令
      ```
      ng serve --proxy-config proxy.conf.json
      ```
      3. 启动项目的时候执行 npm run start 或者 ng serve --proxy-config proxy.conf.json

