# Java doc

## 写在类上面的Javadoc

写在类上的文档标注一般分为三段：

| 步骤     | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| 概要描述 | 通常用一句或者一段话简要描述该类的作用，以英文句号作为结束   |
| 详细描述 | 通常用一段或者多段话来详细描述该类的作用，一般每段话都以英文句号作为结束 |
| 文档标注 | 用于标注作者、创建时间、参阅类等信息                         |

类上常见的文档标注如下：

| 标注     | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| @author  | @author来标记作者，如果一个文件有多个作者来维护就标记多个@author，@author 后面可以跟作者姓名(也可以附带邮箱地址)、组织名称(也可以附带组织官网地址) |
| @version | @version 用于标记当前版本，默认为1.0                         |
| @since   | @since 一般用于标记文件创建时项目当时对应的版本，一般后面跟版本号，也可以跟是一个时间，表示文件当前创建的时间 |
| @see     | @see 一般用于标记该类相关联的类,@see即可以用在类上，也可以用在方法上。 |
| @link    | {@link 包名.类名#方法名(参数类型)} 用于快速链接到相关代码    |
| @code    | 一般在Javadoc中只要涉及到类名或者方法名，都需要使用@code进行标记。 |

## 写在方法上的Javadoc

写在方法上的文档标注一般分为三段：

| 步骤     | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| 概要描述 | 通常用一句或者一段话简要描述该方法的作用，以英文句号作为结束 |
| 详细描述 | 通常用一段或者多段话来详细描述该方法的作用，一般每段话都以英文句号作为结束。通常都以p标签开始，而且p标签通常都是单标签，不使用结束标签。其中使用最多的就是p标签和pre标签,ul标签, i标签。 |
| 文档标注 | 用于标注参数、返回值、异常、参阅等                           |

方法上常见的文档标注如下：

| 标注       | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| @param     | @param 后面跟参数名，再跟参数描述                            |
| @return    | @return 跟返回值的描述                                       |
| @throws    | @throws 跟异常类型 异常描述 , 用于描述方法内部可能抛出的异常 |
| @exception | @exception用于描述方法签名throws对应的异常                   |
| @see       | @see既可以用来类上也可以用在方法上，表示可以参考的类或者方法 |

## 写在类成员上的Javadoc

| 标注   | 描述                                        |
| ------ | ------------------------------------------- |
| @value | 用于标注在常量上，{@value} 用于表示常量的值 |

> @inheritDoc用于注解在重写方法或者子类上，用于继承父类中的Javadoc
>
> - 基类的文档注释被继承到了子类
> - 子类可以再加入自己的注释（特殊化扩展）
> - @return @param @throws 也会被继承

## 示例

org.apache.commons.lang.StringUtils

```java
/**
 * <p>Operations on {@link java.lang.String} that are
 * <code>null</code> safe.</p>
 *
 * <p>A side effect of the <code>null</code> handling is that a
 * <code>NullPointerException</code> should be considered a bug in
 * <code>StringUtils</code> (except for deprecated methods).</p>
 *
 * <p>Methods in this class give sample code to explain their operation.
 * The symbol <code>*</code> is used to indicate any input including <code>null</code>.</p>
 * 
 * @see java.lang.String
 * @author <a href="mailto:hps@intermeta.de">Henning P. Schmiedehausen</a>
 * @author Scott Johnson
 * @since 1.0
 * @version $Id: StringUtils.java 1058365 2011-01-13 00:04:49Z niallp $
 */
public class StringUtils {
    /**
     * The empty String <code>""</code>.
     * @since 2.0
     */
    public static final String EMPTY = "";

    /**
     * <p>Checks if a String is not empty ("") and not null.</p>
     *
     * <pre>
     * StringUtils.isNotEmpty(null)      = false
     * StringUtils.isNotEmpty("")        = false
     * StringUtils.isNotEmpty(" ")       = true
     * StringUtils.isNotEmpty("bob")     = true
     * StringUtils.isNotEmpty("  bob  ") = true
     * </pre>
     *
     * @param str  the String to check, may be null
     * @return <code>true</code> if the String is not empty and not null
     */
    public static boolean isNotEmpty(String str) {
        return !StringUtils.isEmpty(str);
    }
}
```

## 参考文档

- [javadoc - The Java API Documentation Generator](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/javadoc.html)
- [Javadoc 使用详解](https://blog.csdn.net/vbirdbest/article/details/80296136)