## 依赖性注入
依赖性注入框架
令牌 构建 依赖
Injector→ provider→object

依赖注入（默认每次注入的实例是同一个实例）
```
constructor(private oc:overlayContainer){
const injector =ReflectiveInjector.redolveAndCreate({
    {provide:Person,useClass:Person},
    {provide:Address,useFactory:()=>{
        if(environment.production){
            return new Address('北京','朝阳')；
        }else{
            return new Address('西藏','拉萨')
        }
     }
    }，
    {provide:Id,useFactory:()=>{
        return Id.getInstance('idcard');
    }
    }
}

```
每次注入的内容为新创建的实例
```
constructor(private oc:overlayContainer){
    {provide:Person,useClass:Person},
    {provide:Address,useFactory:()=>{
        return()=>{
            if(environment.production){
                return new Address('北京','朝阳')；
            }else{
                return new Address('西藏','拉萨')
            }
        }

     }
    }，
    {provide:Id,useFactory:()=>{
        return Id.getInstance('idcard');
    }
    }
}

```
子注入器(每次注入的内容为新创建的实例)
```
const childInjector=injector.resolveAndCreateChild([Person]);
```

注入常量
```
prividers:[{provider:'BASE_CONFIG',useValue:'http://localhost:3000'}]

```

## ChangeDetection
检测程序内部状态，然后反映到UI上
引起状态变化：Events、XHR、Timers
ApplicationRef监听NgZone的onTurnDone，然后执行检测

默认策略
Onpush策略
```ts
@Component({
    changeDetection:changDetectinStrategy.OnPush
})
```
主动检测
```ts
constructor(private cd:ChangeDetectorRef){}
//需要检测的地方加入下列代码
this.cd.markForCheck();
```


