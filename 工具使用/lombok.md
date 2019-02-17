# lombok使用
[Lombok插件的安装与使用 - CSDN博客](https://blog.csdn.net/qq_26118603/article/details/78944704)

## 依赖安装
gradle依赖：compile 'org.projectlombok:lombok:1.16.8'

## 使用方法
- @Data 注解在类上面，省略所有的get set equal toString方法 
- @Getter 注解在属性上，省略所有get方法 
- @Setter 注解在属性上，省略所有的set方法 
- @NoArgsConstructor注解类上，提供无参构造 
- @AllArgsConstructor 注解在类上，提供全参构造