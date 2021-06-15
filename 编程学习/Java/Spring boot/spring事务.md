# Spring事务

不造重复的轮子，也不写重复的博客。

我们不是代码的创造者，但我们是代码的搬运工。

以下博客是小编多方对比、认真筛选，得出质量较高的博客，以供大家参考

## 阅读指南

得力于spring良好的封装，使用spring实现事务管理是很简单的。绝大部分情况你仅需要

在实现类的public方法上添加@Transactional注解即可。如下：

```java
import org.springframework.transaction.annotation.Transactional;

@Service
public class SysUserServiceImpl implements SysUserService {
    
    ...

    @Transactional(rollbackFor = Exception.class)
    public SysUser createSysUser(SysUser sysUser) {
        ...
    }

    public void deleteSysUser(String id) {
        ...
    }

    public SysUser getSysUser(String id) {
        ...
    }

    @Transactional(rollbackFor = Exception.class)
    public SysUser updateSysUser(String id, SysUser sysUser) {
        ...
    }
}
```

虽然@Transactional的使用方式很简单，但同样需要注意点的点也多，我们强烈推荐你继续阅读如下博客。

在如下的博客中，对@Transactional事务进行了详细的讲解，但内容较多，请耐心阅读

[事务@Transactional详解](https://blog.csdn.net/mingyundezuoan/article/details/79017659)

在如下的博客中，总结了@Transactional 注解不生效的各种场景

[spring事务@Transactional 注解不生效场景](https://blog.csdn.net/qq_43399077/article/details/103892010)