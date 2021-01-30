## 成为Java架构师的一些思考

1. 如何做到项目可供他人使用

   配置可通过外部配置

   某些类的行为可供他人自定义

   说明老项目存在什么缺陷？新项目出于什么目的设计？

   项目的使用文档

2. 如何做到项目可供他人开发

   项目的架构图

   统一的API，只要保持API，项目可通过任何语言重写

   项目的分模块
   
3. 为了外对提供服务，封装包的参数尽量使用常见的类型，比如Object、Map：如下

   ```java
   // 使用了一堆自定义类型，导致其他人在使用时必须先了解CustomString和CustomObject是什么，不友好。
   void method(CustomString string, CustomObject object);
   
   // 使用常见类型（推荐使用该方式）
   void method(String string, Object object);
   ```

   

