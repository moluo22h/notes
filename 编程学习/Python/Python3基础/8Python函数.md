## 如何定义一个函数

```python
def funcname(parameter_list):
	pass
```



## 函数如何返回返回值

形式一：返回多个返回值

```python
return value1,value2,...
```

> 通过type(返回值)可发现返回值类型是一个元组tuple
>
> 如何使用返回值
>
> 形式一：并不推荐使用
>
> ```python
> return_value=fuc(parameterlist)
> print(return_value[1],return_value[2])
> ```
>
> 形式二：序列解包方式，推荐使用
>
> ```python
> return_value1,return_value2=fuc(parameterlist)
> print(return_value1,return_value2)
> ```

形式二：返回指定值

```python
return value
```

形式三：只用一个return，常用来结束函数

```python
return
```

形式四：没有return

```
注意：当函数内没有使用return时，python的返回值将为None
```



## 函数参数

形式一：必须参数

```python 
def function_name(param1,param2):
	pass
```

> 调用方式一：普通调用方式
>
> ```python
> function_name(value1,value2)
> ```
>
> 调用方式二：关键字参数，不关注参数顺序，同时可读性更强
>
> ```python
> function_name(param1=value1,param2=value2)
> ```

形式二：默认值参数。当调用不传参时，将会使用默认值

```python
def function_name(param1=default_value1,param2=default_value2,param3=default_value3):
	pass
```

> 注意：非默认参数必须在默认参数之前
>
> 注意：如何不连续为默认值参数赋值
>
> ```python
> # 使用关键字参数方式赋值
> fuction_name(param1=value1,param3=value3)
> ```
>

形式三：可变参

```python

```



参数传递

形参和实参是否会有影响

## 函数参数类型

```
不存在类型
```



## 返回值类型

```
没有放回值类型
```



## 函数调用

由于python是一种解释行语言，python函数调用需要在函数定义之后，正例如下：

```python
函数定义
函数调用
```



设置最大递归数

```python
import sys
sys.setrecursionlimit(100000)
```



