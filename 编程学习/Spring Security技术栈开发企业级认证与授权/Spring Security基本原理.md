# Spring Security 基本原理
1. 新建SecurityConfig类继承自WebSecurityConfigurerAdapter
2. 使用@Configuration注解装饰SecurityConfig类
3. 重写configure(HttpSecurity http)方法
```java
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin()
                .and()
                .authorizeRequests()
                .anyRequest()
                .authenticated();
    }
```
> http.httpBasic()使用弹框验证

## Spring Security 过滤器链

SecurityCountextPersistenceFilter

1. username Password Authentication Filter（Form表单验证）
2. Basic Authentication Filter（Http basic 验证）
3. ......
4. Exception Translation Filter（第5步，认证不通过，捕获原因并引导用户重新认证）
5. FilterSecurity Interceptor（通过认证，核对权限）
6. REST API
> 第1、2、3步允许开发者定义，第4、5步为spring security 内部指定。
