# Spring Security权限注解

本文转载自：[SpringBoot整合SpringSecurity（六）权限注解](https://blog.csdn.net/qq_32867467/article/details/95078794)

## 序言

这一篇说一下比较好用的Spring Security注解。

> 代码请参考 https://github.com/AutismSuperman/springsecurity-example

## 使用

Spring Security默认是禁用注解的，要想开启注解，要在继承`WebSecurityConfigurerAdapter`的类加`@EnableMethodSecurity`注解，并在该类中将`AuthenticationManager`定义为Bean。

```java
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true,securedEnabled=true,jsr250Enabled=true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
```

我们看到`@EnableGlobalMethodSecurity` 分别有`prePostEnabled` 、`securedEnabled`、`jsr250Enabled` 三个字段，其中每个字段代码一种注解支持，默认为false，true为开启。那么我们就一一来说一下这三总注解支持。

### JSR-250注解

主要注解

- @DenyAll
- @RolesAllowed
- @PermitAll

这里面`@DenyAll` 和 `@PermitAll` 相信就不用多说了 代表拒绝和通过。

`@RolesAllowed` 使用示例

```java
@RolesAllowed({"USER", "ADMIN"})
```

代表标注的方法只要具有`USER`, `ADMIN`任意一种权限就可以访问。这里可以省略前缀`ROLE_`，实际的权限可能是`ROLE_ADMIN`。

### securedEnabled注解

主要注解

- @Secured

`@Secured`在方法上指定安全性要求

可以使用`@Secured`在方法上指定安全性要求 角色/权限等 只有对应 角色/权限 的用户才可以调用这些方法。 如果有人试图调用一个方法，但是不拥有所需的 角色/权限，那会将会拒绝访问将引发异常。

`@Secured`使用示例

```java
@Secured("ROLE_ADMIN")
@Secured({ "ROLE_DBA", "ROLE_ADMIN" })
```

还有一点就是`@Secured`,不支持Spring EL表达式

### prePostEnabled注解

这个开启后支持Spring EL表达式 算是蛮厉害的。如果没有访问方法的权限，会抛出`AccessDeniedException`。

主要注解

- @PreAuthorize --适合进入方法之前验证授权
- @PostAuthorize --检查授权方法之后才被执行
- @PostFilter --在方法执行之后执行，而且这里可以调用方法的返回值，然后对返回值进行过滤或处理或修改并返回
- @PreFilter --在方法执行之前执行，而且这里可以调用方法的参数，然后对参数值进行过滤或处理或修改

`@PreAuthorize` 使用例子

在方法执行之前执行，而且这里可以调用方法的参数，也可以得到参数值，这里利用JAVA8的参数名反射特性，如果没有JAVA8，那么也可以利用Spring Secuirty的`@P`标注参数，或利用Spring Data的@Param标注参数。

```java
//无java8
@PreAuthorize("#userId == authentication.principal.userId or hasAuthority(‘ADMIN’)")
void changePassword(@P("userId") long userId ){}
//有java8
@PreAuthorize("#userId == authentication.principal.userId or hasAuthority(‘ADMIN’)")
void changePassword(long userId ){}
```

这里表示在`changePassword`方法执行之前，判断方法参数`userId`的值是否等于`principal`中保存的当前用户的`userId`，或者当前用户是否具有`ROLE_ADMIN`权限，两种符合其一，就可以访问该 方法。

`@PostAuthorize` 使用例子

在方法执行之后执行，而且这里可以调用方法的返回值，如果EL为false，那么该方法也已经执行完了，可能会回滚。EL变量`returnObject`表示返回的对象。

```java
@PostAuthorize("returnObject.userId == authentication.principal.userId or hasPermission(returnObject, 'ADMIN')")
User getUser();
```

@PostFilter

在执行方法之后执行，而且这里可以调用方法的返回值，然后对返回值进行过滤或处理。EL变量returnObject表示返回的对象。只有方法返回的集合或数组类型的才可以使用。（与分页技术不兼容）

@PreFilter

EL变量filterObject表示参数，如果有多个参数，可以使用@filterTarget注解参数，只有方法是集合或数组才行（与分页技术不兼容）。

## 自定义匹配器

另外说一点就是`@PreAuthorize` 和 `@PostAuthorize` 中 除了支持原有的权限表达式之外，也是可以支持自定义的。

比如

定义一个自己的权限匹配器

```java
interface TestPermissionEvaluator {
    boolean check(Authentication authentication);
}

@Service("testPermissionEvaluator")
public class TestPermissionEvaluatorImpl implements TestPermissionEvaluator {

    public boolean check(Authentication authentication) {
        System.out.println("进入了自定义的匹配器" + authentication);
        return false;
    }
}
```

返回true 就是有权限 false 则是无权限 。 然后在方法中这样玩即可

```java
@PreAuthorize("@testPermissionEvaluator.check(authentication)")
public String test0() {
	return "说明你有自定义权限";
}
```

## 异常处理

然后呢异常处理类跟之前一样

```java
@Component
@Slf4j
public class AccessDeniedAuthenticationHandler implements AccessDeniedHandler {
    private final ObjectMapper objectMapper;

    public AccessDeniedAuthenticationHandler(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException {
        log.info("没有权限");
        httpServletResponse.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        httpServletResponse.setContentType("application/json;charset=UTF-8");
        httpServletResponse.getWriter().write(objectMapper.writeValueAsString(e.getMessage()));
    }

}
```

然后在`WebSecurityConfig` 中的 `configure` 中配置即可

```java
http.anyRequest()
    .authenticated()
    .and().exceptionHandling()
    .accessDeniedHandler(accessDeniedAuthenticationHandler);
```

