## 枚举其实是个类

定义枚举类

```python
from enum import Enum

class VIP(Enum):
    YELLOW = 1
    GREEN = 2
    BLACK = 3
    RED = 4
```

## 枚举与与其他类型表示的对比

```python
#类型表示1：变量
yellw=1
green=2

#类型表示2：字典
{'yellow':1,'green':2}

# 类
class TypeDiamond():
    yellow=1
    green=2
```

其他类型表示缺陷

- 可变

- 没有防止相同标签的功能

## 枚举类型、枚举名称、枚举值

```python
print(VIP.GREEN.value)	//获取枚举值
print(VIP.GREEN.name)	//获取枚举名称
print(VIP.GREEN)		//枚举类型
print(VIP['GREEN'])
```

枚举可以和枚举进行等值比较，但不可以进行大小比较，不可以和非枚举值进行比较