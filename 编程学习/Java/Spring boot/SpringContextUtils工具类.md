# SpringContextUtils工具类

本文转载自：[SPRINGBOOT中通过SPRINGCONTEXTUTILS工具类获取BEAN](http://www.choupangxia.com/2020/02/15/springboot-springcontextutils/)

本文给大家介绍两种通过SpringContextUtils工具类来获取Bean的方法，SpringContextUtils工具类只是大家按照通常命名的规则的一个普通工具类，当然你也可以用其他名字。

## 方式一：实现ApplicationContextAware

具体代码如下：

```java
package com.ctrip.common.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

@Component
public class SpringContextUtils implements ApplicationContextAware{
    private static ApplicationContext applicationContext;
    /**
     * 实现ApplicationContextAware接口的context注入函数, 将其存入静态变量.
     */
    public void setApplicationContext(ApplicationContext applicationContext) {
        if (SpringContextUtils.applicationContext == null) {
            SpringContextUtils.applicationContext = applicationContext;
        }
    }

    /**
     * 取得存储在静态变量中的ApplicationContext.
     */
    public static ApplicationContext getApplicationContext() {
        checkApplicationContext();
        return applicationContext;
    }

    /**
     * 清除applicationContext静态变量.
     */
    public static void cleanApplicationContext() {
        applicationContext = null;
    }

    private static void checkApplicationContext() {
        if (applicationContext == null) {
            throw new IllegalStateException("applicaitonContext未注入,请在applicationContext.xml中定义SpringContextHolder");
        }
    }

    /**
     * 从静态变量ApplicationContext中取得Bean, 自动转型为所赋值对象的类型.
     */
    @SuppressWarnings("unchecked")
    public static <T> T getBean(String name) {
        checkApplicationContext();
        return (T) applicationContext.getBean(name);
    }

    /**
     * 从静态变量ApplicationContext中取得Bean, 自动转型为所赋值对象的类型.
     */
    @SuppressWarnings("unchecked")
    public static <T> T getBean(Class<T> clazz) {
        checkApplicationContext();
        return (T) applicationContext.getBean(clazz);
    }
}
```

这种方式是通过实现ApplicationContextAware接口，来获得ApplicationContext，然后在通过ApplicationContext的方法来获取对应的Bean，比如根据Bean name来获取对应的Bean。

## 方式二：SpringBoot启动类设置ApplicationContext

先看SpringContextUtils的工具类实现：

```java
import org.springframework.context.ApplicationContext;

public class SpringContextUtils {

    private static ApplicationContext applicationContext;

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public static void setApplicationContext(ApplicationContext context) {
        applicationContext = context;
    }

    public static Object getBean(String name) {
        return applicationContext.getBean(name);
    }

    public static Object getBean(Class<?> requiredType) {
        return applicationContext.getBean(requiredType);
    }
}
```

由于该类并没有实现ApplicationContextAware接口，因此得在某一个地方先设置好ApplicationContext的值，在其他地方调用是进行获取。

设置ApplicationContextAware的位置看位于Spring Boot的启动main方法中：

```java
public static void main(String[] args) {
        SpringApplication app = new SpringApplication(WalletApiApplication.class);
        ConfigurableApplicationContext ctx = app.run(args);
        SpringContextUtils.setApplicationContext(ctx);
    }
```

在Spring Boot的启动时调用的run方法会返回一个ConfigurableApplicationContext，将其设置到SpringContextUtils的属性中，后续也可以直接进行调用和使用。