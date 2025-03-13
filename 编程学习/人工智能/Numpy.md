# 探索 NumPy：Python 科学计算的基石

在 Python 的数据科学与数值计算领域，NumPy 无疑是一颗耀眼的明星。作为 Python 中用于科学计算的基础库，NumPy 提供了高效的多维数组对象以及处理这些数组的各种工具。本文将带您深入了解 NumPy 的基本使用，感受它的强大魅力。

## 一、安装与导入

在使用 NumPy 之前，首先要确保它已经安装在您的 Python 环境中。如果您使用的是 Anaconda 发行版，NumPy 通常已经预装。若未安装，可以使用如下命令进行安装：

```python
pip install numpy
```

> 提示：若下载过慢，可使用国内镜像源进行加速，以清华大学镜像源为例，命令如下。更多国内镜像源请见：[附录一：pip国内镜像源](#附录一：pip国内镜像源)
>
> ```bash
> pip install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
> ```

安装完成后，在 Python 脚本或交互式环境中导入 NumPy 库：

```python
import numpy as np
```

`np` 是 NumPy 约定俗成的别名，使用它可以让代码更加简洁易读。



## 二、基本使用

### 1. NumPy 数组：核心数据结构
NumPy 的核心是 `ndarray`（N-dimensional array，多维数组）对象。与 Python 内置的列表相比，NumPy 数组在存储和操作数据时更加高效，因为它在内存中是连续存储的，并且可以利用底层的 C 语言实现进行快速计算。

#### 1.1 创建数组

在下面代码中，我们将为你展示了多种创建 NumPy 数组的方法。

`np.array()` 用于从 Python 列表创建数组；`np.zeros()` 和 `np.ones()` 分别用于创建全零和全一数组，需要传入一个元组指定数组的形状；`np.arange()` 类似于 Python 的 `range()` 函数，但返回的是 NumPy 数组。

```python
import numpy as np

# 从 Python 列表创建一维数组
arr1 = np.array([1, 2, 3, 4, 5])
print("一维数组:", arr1)

# 创建二维数组
arr2 = np.array([[1, 2, 3], [4, 5, 6]])
print("二维数组:\n", arr2)

# 创建全零数组
zeros_arr = np.zeros((3, 4))
print("全零数组:\n", zeros_arr)

# 创建全一数组
ones_arr = np.ones((2, 2))
print("全一数组:\n", ones_arr)

# 创建对角线为一其他为零的数组
eye_arr = np.eye(3)
print("对角线为一其他为零的数组:\n", eye_arr)

# 创建指定范围和步长的数组
range_arr = np.arange(0, 10, 2)
print("指定范围和步长的数组:", range_arr)
```

> 运行结果如下：
>
> ```
> 一维数组: [1 2 3 4 5]
> 二维数组:
>  [[1 2 3]
>  [4 5 6]]
> 全零数组:
>  [[0. 0. 0. 0.]
>  [0. 0. 0. 0.]
>  [0. 0. 0. 0.]]
> 全一数组:
>  [[1. 1.]
>  [1. 1.]]
> 对角线为一其他为零的数组:
>  [[1. 0. 0.]
>  [0. 1. 0.]
>  [0. 0. 1.]]
> 指定范围和步长的数组: [0 2 4 6 8]
> ```

#### 1.2 数组的基本属性

通过数组的 `shape`、`ndim`、`size` 和 `dtype` 属性，我们可以方便地获取数组的形状、维度、元素个数和数据类型等信息。

```python
# 查看数组的形状
print("arr2 的形状:", arr2.shape)

# 查看数组的维度
print("arr2 的维度:", arr2.ndim)

# 查看数组的元素个数
print("arr2 的元素个数:", arr2.size)

# 查看数组的数据类型
print("arr2 的数据类型:", arr2.dtype)
```
> 运行结果如下：
>
> ```
> arr2 的形状: (2, 3)
> arr2 的维度: 2
> arr2 的元素个数: 6
> arr2 的数据类型: int64
> ```

### 2. 数组的索引与切片
#### 2.1 一维数组的索引与切片

一维数组的索引和切片操作与 Python 列表类似，索引从 0 开始，切片使用 `[start:stop:step]` 的形式。

```python
arr = np.array([10, 20, 30, 40, 50])

# 索引单个元素
print("索引第 3 个元素:", arr[2])

# 切片操作
print("获取第 2 到第 4 个元素:", arr[1:4])
```
> 运行结果如下：
>
> ```
> 索引第 3 个元素: 30
> 获取第 2 到第 4 个元素: [20 30 40]
> ```

#### 2.2 多维数组的索引与切片

多维数组的索引和切片需要使用逗号分隔不同维度的索引或切片范围。

```python
arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# 索引单个元素
print("索引第 2 行第 3 列的元素:", arr[1, 2])

# 切片操作
print("获取前两行的前两列元素:\n", arr[:2, :2])
```
> 运行结果如下：
>
> ```
> 索引第 2 行第 3 列的元素: 6
> 获取前两行的前两列元素:
>  [[1 2]
>  [4 5]]
> ```

### 3. 数组的运算
#### 3.1 算术运算

NumPy 数组的算术运算会对数组中的每个元素进行相应的操作，要求两个数组的形状相同。

```python
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])

# 加法
print("数组相加:", arr1 + arr2)

# 乘法
print("数组相乘:", arr1 * arr2)
```
> 运行结果如下：
>
> ```
> 数组相加: [5 7 9]
> 数组相乘: [ 4 10 18]
> ```

#### 3.2 矩阵运算

使用 `np.dot()` 函数可以进行矩阵乘法运算。

```python
arr1 = np.array([[1, 2], [3, 4]])
arr2 = np.array([[5, 6], [7, 8]])

# 矩阵乘法
matrix_product = np.dot(arr1, arr2)
print("矩阵乘法结果:\n", matrix_product)
```
> 运行结果如下
>
> ```
> 矩阵乘法结果:
>  [[19 22]
>  [43 50]]
> ```

### 4. 数组的统计计算

NumPy 提供了丰富的统计函数，如 `np.mean()`、`np.median()`、`np.min()`、`np.max()`、`np.std()` 、`np.var()` 等，用于计算数组的各种统计指标。

```python
arr = np.array([1, 2, 3, 4, 5])

# 计算数组的平均值
mean_value = np.mean(arr)
print("数组的平均值:", mean_value)

# 计算数组的中位数
median_value=np.median(arr)
print("数组的中位数:", median_value)

# 计算数组的最小值
min_value = np.min(arr)
print("数组的最小值:", min_value)

# 计算数组的最大值
max_value = np.max(arr)
print("数组的最大值:", max_value)

# 计算数组的标准差
std_value = np.std(arr)
print("数组的标准差:", std_value)

# 计算数组的方差
var_value = np.var(arr)
print("数组的方差:", var_value)
```
> 运行结果如下：
>
> ```
> 数组的平均值: 3.0
> 数组的中位数: 3.0
> 数组的最小值: 1
> 数组的最大值: 5
> 数组的标准差: 1.4142135623730951
> 数组的方差: 2.0
> ```

### 5. 数组的形状操作

`flatten()` 方法用于将多维数组展平为一维数组，`reshape()` 方法用于改变数组的形状，但要保证元素个数不变。

```python
arr = np.array([[1, 2, 3], [4, 5, 6]])

# 数组展平
flattened_arr = arr.flatten()
print("展平后的数组:", flattened_arr)

# 改变数组形状
reshaped_arr = arr.reshape(3, 2)
print("改变形状后的数组:\n", reshaped_arr)
```
> 运行结果如下：
>
> ```
> 展平后的数组: [1 2 3 4 5 6]
> 改变形状后的数组:
>  [[1 2]
>  [3 4]
>  [5 6]]
> ```

## 三、扩展说明

本文仅介绍NumPy的一些常见操作，但NumPy的功能远不止于此，例如NumPy还可以：

- 创建随机数组、全空数组等
- 计算数组的元素之和、元素乘积、累积和等
- 垂直堆叠、水平堆叠等
- 保存数组到文件、从文件加载数组等

NumPy功能十分强大，远不止我们列举出的这些，更多操作请查询官网：

- 英文官网：[NumPy documentation — NumPy v2.2 Manual](https://numpy.org/doc/stable/)
- 中文官网：[NumPy 文档_Numpy中文网](https://numpy.net/doc/stable/index.html)

## 四、总结

NumPy 是一个功能强大且广泛应用的库，本文只是介绍了它的一些基本用法。通过深入学习和实践，您可以利用 NumPy 处理更复杂的数值计算任务，为数据科学和机器学习等领域的工作打下坚实的基础。希望这篇文章能帮助您快速上手 NumPy，开启科学计算的新旅程。 

## 五、附录

### 附录一：pip国内镜像源

在使用`pip`安装 Python 包时，由于默认的源服务器在国外，下载速度可能会比较慢。使用国内镜像源可以显著提升下载速度。常用国内镜像源如下：

- **清华大学**：`https://pypi.tuna.tsinghua.edu.cn/simple`
- **阿里云**：`https://mirrors.aliyun.com/pypi/simple/`
- **中国科学技术大学**：`https://pypi.mirrors.ustc.edu.cn/simple/`
- **豆瓣**：`https://pypi.doubanio.com/simple/`

## 六、参考文档

- [NumPy documentation — NumPy v2.2 Manual](https://numpy.org/doc/stable/)

- [NumPy 文档_Numpy中文网](https://numpy.net/doc/stable/index.html)