## Bean设计

- VO(value object):用于前端展示使用(例如放置到JSP中解析或者给前端传递数据)
- DTO(data transfer object):用于接口互相调用返回,数据传输(例如很多接口调用返回值或消息队列内容);
- PO(persistence object):用于持久化时(例如保存到数据库或者缓存);

[Java各种对象（PO,BO,VO,DTO,POJO,DAO,Entity,JavaBean,JavaBeans）的区分](https://www.cnblogs.com/lyjin/p/6389349.html)



## VO、BO、DTO相互转换

通过硬编码实现Bean之间相互转化，简单但是费力。要是能对其封装一下就好了。

### 思路一：封装一个工具类实现相互转换

#### 工具类

com.moluo.moapi.common.util.ConvertUtil

```java
package com.moluo.moapi.common.util;

import com.moluo.moapi.common.bean.MoPage;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * 转换工具类
 * <p>
 * 用于实现VO、BO、DTO等对象之间的相互转换
 */
public class ConvertUtil {

    /**
     * 源类型对象转换为目标类型对象
     *
     * @param src   源类型对象
     * @param clazz 目标类
     * @param <S>   源类
     * @param <T>   目标类
     * @return 目标类型对象
     */
    public static <S, T> T convertTo(S src, Class<T> clazz) {
        T result = null;
        try {
            result = clazz.newInstance();
            BeanUtils.copyProperties(src, result);
        } catch (InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 源类型列表转换为目标类型列表
     *
     * @param srcList 源类型列表
     * @param clazz   目标类
     * @param <S>     源类
     * @param <T>     目标类
     * @return 目标类型列表
     */
    public static <S, T> List<T> convertTo(List<S> srcList, Class<T> clazz) {
        List<T> result = new ArrayList<>(srcList.size());
        for (Object srcItem : srcList) {
            try {
                T destItem = clazz.newInstance();
                BeanUtils.copyProperties(srcItem, destItem);
                result.add(destItem);
            } catch (InstantiationException | IllegalAccessException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 源类型Page转换为目标类型MoPage
     *
     * @param srcPage 源类型Page
     * @param clazz   目标类
     * @param <S>     源类
     * @param <T>     目标类
     * @return 目标类型MoPage
     */
    public static <S, T> MoPage<T> convertTo(Page<S> srcPage, Class<T> clazz) {
        MoPage<T> result = new MoPage<>();
        result.setPageNo(srcPage.getNumber() + 1);
        result.setPageSize(srcPage.getPageable().getPageSize());
        result.setTotalCount(srcPage.getTotalElements());
        List<T> list = new ArrayList<>();
        for (Object srcItem : srcPage.getContent()) {
            try {
                T destItem = clazz.newInstance();
                BeanUtils.copyProperties(srcItem, destItem);
                list.add(destItem);
            } catch (InstantiationException | IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        result.setData(list);
        return result;
    }

    /**
     * 源类型Page转换为同类型MoPage
     *
     * @param srcPage 源类型Page
     * @param <T>     源类型
     * @return 同类型MoPage
     */
    public static <T> MoPage<T> convertTo(Page<T> srcPage) {
        MoPage<T> result = new MoPage<>();
        result.setPageNo(srcPage.getNumber() + 1);
        result.setPageSize(srcPage.getPageable().getPageSize());
        result.setTotalCount(srcPage.getTotalElements());
        result.setData(srcPage.getContent());
        return result;
    }

}
```

#### 使用方式

```java
/**
 * 将链接入参转化为链接
 *
 * @param linkParam 链接入参
 * @return 链接
 */
private Link convert(LinkParam linkParam) {
    return ConvertUtil.convertTo(linkParam, Link.class);
}


/**
 * 将链接转化为链接VO
 *
 * @param link 链接
 * @return 链接VO
 */
private LinkVO convert(Link link) {
    return ConvertUtil.convertTo(link, LinkVO.class);
}

/**
 * 根据Page对象生成MoPage
 *
 * @param page 分页
 * @return MoPage
 */
private MoPage<LinkVO> convert(Page<Link> page) {
    return ConvertUtil.convertTo(page, LinkVO.class);
}

/**
 * 将链接列表转化为链接VO列表
 *
 * @param listLinks 链接列表
 * @return 链接VO列表
 */
private List<LinkVO> convert(List<Link> listLinks) {
    return ConvertUtil.convertTo(listLinks, LinkVO.class);
}
```

#### 意见

`LinkVO linkVo = ConvertUtil.convertTo(link, LinkVO.class);`的方式看起来已经挺简洁了，但或许它还可以更简洁，比如省略LinkVO.class，达到`LinkVO linkVo = ConvertUtil.convertTo(link);`的效果

### 思路二：编写一个父类实现相互转换

#### 父类

com.moluo.moapi.common.BaseController

```java
package com.moluo.moapi.common;

import com.moluo.moapi.common.bean.MoPage;
import com.moluo.moapi.common.util.ConvertUtil;
import com.moluo.moapi.model.entity.base.BaseEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Controller基础类
 */
public abstract class BaseController {

    /**
     * 将Param转化为Entity
     *
     * @param param 入参
     * @param <E>   Entity类型
     * @param <P>   Param类型
     * @return Entity
     */
    protected <E extends BaseEntity, P extends BaseParam> E convert(P param) {
        E result = null;
        try {
            result = (E) getEntityClass().newInstance();
            BeanUtils.copyProperties(param, result);
        } catch (InstantiationException | IllegalAccessException ex) {
            ex.printStackTrace();
        }
        return result;
    }

    /**
     * 将Entity转化为VO
     *
     * @param entity 实体
     * @param <E>    Entity类型
     * @param <VO>   VO类型
     * @return VO
     */
    protected <E extends BaseEntity, VO extends BaseVO> VO convert(E entity) {
        VO result = null;
        try {
            result = (VO) getVoClass().newInstance();
            BeanUtils.copyProperties(entity, result);
        } catch (InstantiationException | IllegalAccessException ex) {
            ex.printStackTrace();
        }
        return result;
    }


    /**
     * 将Page<Entity>转化为MoPage<VO>
     *
     * @param srcPage 源Page
     * @param <VO>    VO类型
     * @param <E>     Entity类型
     * @return MoPage<VO>
     */
    protected <VO extends BaseVO, E extends BaseEntity> MoPage<VO> convert(Page<E> srcPage) {
        return ConvertUtil.convertTo(srcPage, getEntityClass());
    }

    /**
     * 将Entity列表转化为VO列表
     *
     * @param srcList Entity列表
     * @param <VO>    VO类型
     * @param <E>     Entity类型
     * @return VO列表
     */
    protected <VO extends BaseVO, E extends BaseEntity> List<VO> convert(List<E> srcList) {
        return ConvertUtil.convertTo(srcList, getVoClass());
    }

    /**
     * 获取VO的类型
     *
     * @return VO的类型
     */
    public abstract Class getVoClass();

    /**
     * 获取Param的类型
     *
     * @return Param的类型
     */
    public abstract Class getParamClass();

    /**
     * 获取Entity的类型
     *
     * @return Entity的类型
     */
    public abstract Class getEntityClass();


}
```

com.moluo.moapi.common.BaseVO

```java
package com.moluo.moapi.common;

/**
 * VO基础类
 */
public class BaseVO {
}
```

com.moluo.moapi.common.BaseParam

```java
package com.moluo.moapi.common;

/**
 * Param基础类
 */
public class BaseParam {
}
```

#### 使用方式

com.moluo.moapi.life.controller.LifeEventController

```java
package com.moluo.moapi.life.controller;

import com.moluo.moapi.common.BaseController;

public class LifeEventController extends BaseController {

    @Autowired
    private LifeEventService lifeEventService;
    
    ...

    public LifeVo createLifeEvent(LifeParam lifeParam) {
        LifeEvent lifeEvent = convert(lifeParam);
        return convert(lifeEventService.createLifeEvent(lifeEvent));
    }

    @Override
    public Class getVoClass() {
        return LifeVo.class;
    }

    @Override
    public Class getParamClass() {
        return LifeParam.class;
    }

    @Override
    public Class getEntityClass() {
        return LifeEvent.class;
    }
}
```

#### 意见

通过父类对转换逻辑的封装，使用户不必关心VO、BO具体如何转换。只需要记住通过convert()方式就可以实现转换。但各个bean需要继承指定的基础Bean，例如VO需要继承BaseVO，会令人感到束缚。同时还需要实现`getVoClass() `、`getParamClass() `、`getEntityClass() `方法也令人不悦。

### 思路三：编写一个接口实现相互转换

#### 接口

com.moluo.moapi.common.Controller

```java
package com.moluo.moapi.common;

import com.moluo.moapi.common.bean.MoPage;
import com.moluo.moapi.model.entity.base.BaseEntity;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Controller基础接口
 */
public interface Controller<T extends BaseParam, S extends BaseEntity, U extends BaseVO> {
    /**
     * 将Param转化为Entity
     *
     * @param t 入参
     * @return Entity
     */
    S convert(T t);

    /**
     * 将Entity转化为VO
     *
     * @param s 实体
     * @return VO
     */
    U convert(S s);

    /**
     * 将Page<Entity>转化为MoPage<VO>
     *
     * @param page 源Page
     * @return MoPage<VO>
     */
    MoPage<U> convert(Page<S> page);

    /**
     * 将Entity列表转化为VO列表
     *
     * @param list Entity列表
     * @return VO列表
     */
    List<U> convert(List<S> list);

}
```

com.moluo.moapi.common.BaseVO

```java
package com.moluo.moapi.common;

/**
 * VO基础接口
 */
public interface BaseVO {
}
```

com.moluo.moapi.common.BaseParam

```java
package com.moluo.moapi.common;

/**
 * Param基础接口
 */
public interface BaseParam {
}
```

#### 使用方式

```java
package com.moluo.moapi.link.controller;

/**
 * 链接(Link)表控制层
 */
public class LinkController implements Controller<LinkParam, Link, LinkVO> {

    ...
        
    @Override
    public Link convert(LinkParam linkParam) {
        return null;
    }

    @Override
    public LinkVO convert(Link link) {
        return null;
    }

    @Override
    public MoPage<LinkVO> convert(Page<Link> page) {
        return null;
    }

    @Override
    public List<LinkVO> convert(List<Link> list) {
        return null;
    }
}
```

#### 意见

相比手写转换方法，通过实现Controller接口，可以快速搭建转换方法架构（通过ALT+ENTER让IDE自动生成）。但仅有框架，开发者仍需要编写具体实现代码。

### 讨论

小编最希望实现的效果是：只继承一个父类，无须重写任何方法，即可通过统一的convert()方法实现各Bean之间的转换。但由于在父类中无法直接获取到泛型的Class，导致小编不得不将获取Class的逻辑转移到子类中，最终形成令人不甚满意的思路二，令人十分可惜。

记录以上三种思路，希望未来能找到更优雅的实现方式。

