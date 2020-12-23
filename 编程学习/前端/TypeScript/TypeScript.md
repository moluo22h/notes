ES是脚本语言的规划
JavaScript  ES5
TypeScript ES6



学习TypeScript的好处




## 安装TypeScript开发环境
compiler
使用在线compiler开发
本地compiler
npm node package manage
使用npm安装ts：npm install -g typescript
将ts文件编译为js文件：tsc hello.ts

## 字符串新特性
多行字符串  双撇号 ``
字符串模板 ${ }  只有在双撇号中才有用
自动拆分字符串

## TypeScript参数类型
- any string number boolean 
- void 用于声明返回值
- 自定义类型

用：赋类型



```ts
var myname:string="xxx"



class Person{
    name:string;
    age:number;
}

```


TypeSctipt参数默认值
- 变量默认值
- 方法默认值
	带默认值的参数要放在最后


```ts
function test(a:string,b:string,c:string="jojo"){
    console.log(a);
}

test("xxx")

```

可选参数
用问号设置参数为默认值
可选参数需要申明在必选参数之后

> 注意：使用可选时，要处理可选参数为空的情况

```ts
function test(a:string,b?:string){
    
}

```


## Rest and Spread操作符
任意数量的参数
...args

```ts
function fun1(...args){
    args.foreach(function(arg){
        console.log(arg)
    })
}

```


## generator函数
手动暂停和恢复代码执行
TypeScript编译器： babel

```ts
function* dosomething(){
    console.log("start")
    yield
    concole.log("finish")
}

var func1=doSomething()
func1.next()

```

析构表达式
用法一：从对象中取值
用{}
使用
别名
嵌套

```ts

function getStock(){
    return{
        code:"IBM"
        price:100
        prices:{
            price1:200,
            price2：300
        }
    }
}
var{code,price}=getStock();
var{code:codex,price}=getStock();
var{code,price,prices:{price1}}=getStock();
console.log(code);
console.log(price);
```


用法二：从数组中取值
用[]

```ts

var [number1,bumber2,...others]=array1

```

用法三：当参数


## 箭头表达式

=> 代替了function
用来声明匿名表达式，

javaScript this关键字
```ts
var sum=(arg1,arg2)=>arg1+arg2;

var sum =()=>{
    
}

var sum=arg1=>{
    
}
```


for of 循环
```ts
var myArray={1,2,3,4};
myArray.desc="four number"

myArray.forEach(value=>console.log(value))


//  n其实是key JavaScript
for(var n in myArray){
    console.log(n);
    console.log(myArray[n])
}

// 忽略属性 n是value
for(var n of myArray){
   if(n>2) break;
   console.log(n)
}


```


## 类
访问控制符 public private protested


```ts



class Person{
name;

eat(){
    concole.log("")
}



}

class Employee extends Person{
    
}




var p1=new Person();
p1.name="batman";
p1.eat();


```


## 类型定义文件
*.d.ts
在ts用js工具包

typings


