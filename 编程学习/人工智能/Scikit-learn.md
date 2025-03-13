# Scikit-learn：Python 机器学习的瑞士军刀

在机器学习领域，Python 凭借丰富的库和工具成为众多开发者的首选语言。其中，Scikit-learn 无疑是一颗璀璨的明星，它提供了丰富的机器学习算法和工具，涵盖分类、回归、聚类等多种任务，让开发者能够高效地构建和评估机器学习模型。本文将深入介绍 Scikit-learn 的基本使用方法。

## 安装与导入

在使用 Scikit-learn 之前，需要先安装它。如果你使用的是 Anaconda 环境，通常已经预装。若没有安装，可以通过pip install -U scikit-learn进行安装。

安装完成后，在 Python 脚本或交互式环境中导入该库：

```python
import sklearn
```

为了使用具体的算法和工具，还需要从sklearn中导入相应的模块，例如导入逻辑回归模型：

```python
from sklearn.linear_model import LogisticRegression
```

## 2. 核心概念

### 2.1 数据集

Scikit-learn 提供了丰富多样的数据集，大致可分为内置小数据集、可下载数据集和生成数据集三类，非常便于学习和测试模型 。以下是对各类数据集的详细介绍及加载示例：

#### 内置小数据集：

```python
from sklearn.datasets import load_iris
iris = load_iris()
X = iris.data
y = iris.target
```

```python
from sklearn.datasets import load_digits
digits = load_digits()
X = digits.data
y = digits.target
```

```python
from sklearn.datasets import load_boston
boston = load_boston()
X = boston.data
y = boston.target
```

```python
from sklearn.datasets import load_diabetes
diabetes = load_diabetes()
X = diabetes.data
y = diabetes.target
```

- **鸢尾花数据集（Iris Dataset）**：经典的分类数据集，包含 150 个样本，4 个特征（花萼长度、花萼宽度、花瓣长度、花瓣宽度），用于预测鸢尾花的品种，共有 3 个类别。
- **手写数字数据集（Digits Dataset）**：由 8x8 像素的手写数字图像组成，包含 1797 个样本，每个样本有 64 个特征（对应图像的每个像素值），目标是识别 0 - 9 的数字。
- **波士顿房价数据集（Boston House Prices Dataset）**：用于回归任务，包含 506 个样本，13 个特征，如犯罪率、住宅平均房间数等，目标是预测波士顿地区的房价中位数。
- **糖尿病数据集（Diabetes Dataset）**：也是回归数据集，有 442 个样本，10 个特征，用于预测糖尿病的发病情况，指标为一年后疾病进展的定量测量。

#### 可下载数据集：

```python
from sklearn.datasets import fetch_20newsgroups
newsgroups_train = fetch_20newsgroups(subset='train')
X = newsgroups_train.data
y = newsgroups_train.target
```

```python
from sklearnext.datasets import fetch_imdb
imdb = fetch_imdb()
X = imdb.data
y = imdb.target
```

- **20 Newsgroups 数据集**：文本分类数据集，包含 20 个不同主题的新闻文章，可用于文本分类、文本挖掘和信息检索研究。在加载时，需要先下载数据集，可使用`fetch_20newsgroups`函数，并且可以通过subset参数指定加载训练集或测试集等。
- **IMDB 影评数据集**：用于影评情感分析，分为正面和负面影评，是自然语言处理中情感分析任务的常用数据集。在 Scikit-learn 中，加载 IMDB 影评数据集需要先安装`scikit - learn - extra`库，然后使用`fetch_imdb`函数。

#### 生成数据集：

```python
from sklearn.datasets import make_classification
X, y = make_classification(n_samples=100, n_features=10, n_classes=3, random_state=42)
```

```python
from sklearn.datasets import make_regression
X, y = make_regression(n_samples=100, n_features=5, noise=0.1, random_state=42)
```

```python
from sklearn.datasets import make_blobs
X, y = make_blobs(n_samples=150, n_features=2, centers=3, random_state=42)
```

- **make_classification**：生成用于分类问题的合成数据集，可自定义样本数量、特征数量、类别数量等参数，用于测试分类算法性能。
- **make_regression**：生成用于回归问题的数据集，能控制噪声、特征之间的相关性等，方便评估回归模型。
- **make_blobs**：生成用于聚类的数据集，数据点分布在多个团簇中，常用于测试聚类算法，如 K-Means。

这里的X是特征矩阵，每一行代表一个样本，每一列代表一个特征；y是目标向量，即每个样本对应的类别标签（对于回归任务则是目标值）。

### 2.2 模型选择与评估

在 Scikit-learn 中，模型的选择和评估非常重要。通常我们会将数据集划分为训练集和测试集，使用训练集训练模型，使用测试集评估模型的性能。划分数据集可以使用train_test_split函数：

```python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```

test_size表示测试集所占的比例，random_state用于设置随机种子，保证每次划分的结果一致。

评估模型性能可以使用不同的指标，针对不同的任务，常用的评估指标及示例如下：

#### 分类任务：

```python
from sklearn.metrics import accuracy_score
model = LogisticRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print(f"准确率: {accuracy}")

from sklearn.metrics import precision_score
precision = precision_score(y_test, y_pred, average='weighted')
print(f"精确率: {precision}")

from sklearn.metrics import recall_score
recall = recall_score(y_test, y_pred, average='weighted')
print(f"召回率: {recall}")

from sklearn.metrics import f1_score
f1 = f1_score(y_test, y_pred, average='weighted')
print(f"F1值: {f1}")

from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
print("混淆矩阵:\n", cm)
```

可视化评估对比 - 分类散点图

集中度越高越好（越接近直线分布）。完美的线性回归应该是45度直线，代表预测值和真实值一样。

```python
from matplotlib import pyplot as plt

plt.scatter(y_test, y_pred)
plt.title('y_test vs y_pred')
plt.xlabel('y_test')
plt.ylabel('y_pred')
plt.show()
```

[一文详解ROC曲线和AUC值 - 知乎](https://zhuanlan.zhihu.com/p/616190701)

- **准确率（Accuracy）**：分类正确的样本数占总样本数的比例，计算公式为$Accuracy = \frac{TP + TN}{TP + TN + FP + FN}$，其中\(TP\)（True Positive）表示真正例，\(TN\)（True Negative）表示真反例，\(FP\)（False Positive）表示假正例，\(FN\)（False Negative）表示假反例。在样本类别分布均衡时，准确率能较好地反映模型性能，但在类别不均衡时，可能会产生误导。

- **精确率（Precision）**：在所有预测为正例的样本中，实际为正例的比例，计算公式为$Precision = \frac{TP}{TP + FP}$。对于 “查准” 需求较高的场景，如垃圾邮件识别，精确率很重要。

- **召回率（Recall）**：在所有实际为正例的样本中，被正确预测为正例的比例，计算公式为$Recall = \frac{TP}{TP + FN}$。像疾病诊断场景，希望尽可能找出所有患病样本，召回率就更为关键。

- **F1 值（F1-Score）**：综合考虑精确率和召回率的指标，计算公式为$F1 = 2 \times \frac{Precision \times Recall}{Precision + Recall}$，它是精确率和召回率的调和平均数，能更全面地评估模型性能。

- **混淆矩阵（Confusion Matrix）**：以矩阵形式直观展示模型在各个类别上的预测情况，行表示真实类别，列表示预测类别，通过它可以清晰地看到\(TP\)、\(TN\)、\(FP\)、\(FN\)的数量，从而计算出其他评估指标。

#### 回归任务：

```python
from sklearn.metrics import mean_squared_error

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
print(f"均方误差: {mse}")
```

```python
from sklearn.metrics import mean_squared_error
import numpy as np

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
print(f"均方根误差: {rmse}")
```

```python
from sklearn.metrics import mean_absolute_error

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
mae = mean_absolute_error(y_test, y_pred)
print(f"平均绝对误差: {mae}")
```

```python
from sklearn.metrics import r2_score

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
r2 = r2_score(y_test, y_pred)
print(f"决定系数R²: {r2}")
```

可视化评估对比

集中度越高越好（越接近直线分布）。完美的线性回归应该是45度直线，代表预测值和真实值一样。

```python
from matplotlib import pyplot as plt

plt.scatter(y_test, y_pred)
plt.title('y_test vs y_pred')
plt.xlabel('y_test')
plt.ylabel('y_pred')
plt.show()
```



- **均方误差（Mean Squared Error，MSE）**：预测值与真实值之差的平方的平均值，计算公式为$MSE = \frac{1}{n} \sum_{i=1}^{n}(y_i - \hat{y}_i)^2$，$y_i$为真实值，$\hat{y}_i$为预测值，$n$为样本数量。MSE 值越小，说明模型预测越准确，但由于平方运算，对离群点较为敏感。
- **均方根误差（Root Mean Squared Error，RMSE）**：MSE 的平方根，即$RMSE = \sqrt{MSE}$，与 MSE 相比，RMSE 更直观地反映预测值与真实值误差的平均幅度，单位与真实值相同。
- **平均绝对误差（Mean Absolute Error，MAE）**：预测值与真实值之差的绝对值的平均值，计算公式为$MAE = \frac{1}{n} \sum_{i=1}^{n}|y_i - \hat{y}_i|$，MAE 对所有误差一视同仁，不受离群点的影响过大。
- **决定系数（Coefficient of Determination，**$R^2$**）**：衡量模型对数据的拟合优度，取值范围在\([0, 1]\)，$R^2 = 1 - \frac{\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}{\sum_{i=1}^{n}(y_i - \bar{y})^2}$，其中$\bar{y}$是真实值的均值。$R^2$越接近 1，说明模型对数据的拟合效果越好。

#### 聚类任务：

```python
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
model = KMeans(n_clusters=3)
model.fit(X)
labels = model.labels_
silhouette = silhouette_score(X, labels)
print(f"轮廓系数: {silhouette}")

from sklearn.cluster import KMeans
from sklearn.metrics import calinski_harabasz_score
model = KMeans(n_clusters=3)
model.fit(X)
labels = model.labels_
ch_score = calinski_harabasz_score(X, labels)
print(f"Calinski-Harabasz指数: {ch_score}")
```

- **轮廓系数（Silhouette Coefficient）**：综合考虑样本与同一簇内其他样本的紧密程度（凝聚度）和与其他簇中样本的分离程度（分离度），计算公式为$s = \frac{b - a}{max(a, b)}$，其中\(a\)是样本与同一簇内其他样本的平均距离，\(b\)是样本与最近邻簇中样本的平均距离。轮廓系数取值范围在\([-1, 1]\)，越接近 1 表示聚类效果越好，越接近 -1 表示样本可能被错误分类，接近 0 表示样本处于两个簇的边界。

- **Calinski-Harabasz 指数（Calinski-Harabasz Index）**：基于簇内方差和簇间方差计算，$CH = \frac{(n_k - 1) \times B}{(n - n_k) \times W}$，其中\(n\)是样本总数，\(n_k\)是簇的数量，\(B\)是簇间方差，\(W\)是簇内方差。CH 指数越大，说明聚类效果越好，簇内样本越紧密，簇间样本越分离。

- 无真实标签的评估指标：
  - **轮廓系数（Silhouette Score）**：通过计算每个样本的轮廓系数并取平均值得到。轮廓系数衡量了样本与其所在簇的紧密程度以及与其他簇的分离程度，取值范围为 [-1, 1]，值越接近 1 表示聚类效果越好。
  - **Calinski-Harabasz 指数**：也称为方差比准则，它衡量了类间离散度与类内离散度的比值，值越大表示聚类效果越好。
  - **Davies-Bouldin 指数**：该指数衡量了每个簇与其他簇的平均相似度，值越小表示聚类效果越好。

- 有真实标签的评估指标：
  - **调整兰德指数（Adjusted Rand Index, ARI）**：用于衡量两个聚类结果（这里是预测结果和真实标签）的相似性，取值范围为 [-1, 1]，值越接近 1 表示聚类结果与真实标签越一致。
  - **归一化互信息（Normalized Mutual Information, NMI）**：同样用于衡量两个聚类结果的相似性，取值范围为 [0, 1]，值越接近 1 表示聚类结果与真实标签越一致。

## 3. 常见模型的使用

### 3.1 分类模型

#### 逻辑回归

逻辑回归是一种广泛应用的线性分类模型，适用于二分类和多分类问题。

```python
from sklearn.linear_model import LogisticRegression

# 创建逻辑回归模型实例
model = LogisticRegression()
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

#### 决策树

决策树是一种基于树结构的分类模型，它通过对特征进行划分来构建决策规则。

```python
from sklearn.tree import DecisionTreeClassifier

# 创建决策树模型实例
model = DecisionTreeClassifier()
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

#### 支持向量机（Support Vector Machine，SVM）

SVM 是一种有监督的学习模型，可用于分类和回归任务。在分类任务中，它的目标是寻找一个最优的超平面，将不同类别的数据点尽可能分开。对于线性可分的数据，使用线性核函数；对于线性不可分的数据，可通过核技巧将数据映射到高维空间，常用的核函数有径向基核函数（RBF）等。

```python
from sklearn.svm import SVC

# 创建SVM分类器实例，使用RBF核函数
model = SVC(kernel='rbf')
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

#### 随机森林（Random Forest）

随机森林是一种基于决策树的集成学习算法，它通过构建多个决策树并将它们的预测结果进行组合来提高模型的泛化能力和稳定性。在构建每棵决策树时，会随机选择部分特征和样本，这样可以减少过拟合。随机森林适用于分类和回归任务，尤其在处理高维数据和大量数据时表现出色。

```python
from sklearn.ensemble import RandomForestClassifier

# 创建随机森林分类器实例，设置树的数量为100
model = RandomForestClassifier(n_estimators=100)
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

#### 多层感知机（Multi-Layer Perceptron，MLP）

多层感知机是一种前馈人工神经网络，由输入层、多个隐藏层和输出层组成。每个神经元与下一层的神经元通过权重连接，通过反向传播算法来调整权重，以最小化预测值与真实值之间的误差。在 Scikit-learn 中，MLPClassifier用于分类任务，MLPRegressor用于回归任务。

```python
from sklearn.neural_network import MLPClassifier

# 创建多层感知机分类器实例，设置隐藏层结构为(100, 50)
model = MLPClassifier(hidden_layer_sizes=(100, 50))
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

### 3.2 回归模型

#### 线性回归

线性回归是一种简单而常用的回归模型，用于预测连续型变量。
$$
y = ax + b
$$

```python
from sklearn.linear_model import LinearRegression

# 创建线性回归模型实例
model = LinearRegression()
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

> 获取公式参数
>
> ```python
> a = model.coef_
> b = model.intercept_
> ```

#### 岭回归

岭回归是一种改进的线性回归，通过在损失函数中添加 L2 正则化项来防止过拟合。

```python
from sklearn.linear_model import Ridge

# 创建岭回归模型实例
model = Ridge(alpha=0.5)
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

alpha是正则化系数，用于控制正则化的强度。

#### lasso 回归（Least Absolute Shrinkage and Selection Operator Regression）

lasso 回归也是一种线性回归的改进方法，它在损失函数中添加 L1 正则化项。L1 正则化可以使部分特征的系数变为 0，从而实现特征选择的功能，适用于数据中存在较多冗余特征的情况。

```python
from sklearn.linear_model import Lasso

# 创建lasso回归模型实例，设置正则化系数为0.1
model = Lasso(alpha=0.1)
# 训练模型
model.fit(X_train, y_train)
# 预测
y_pred = model.predict(X_test)
```

### 3.3 聚类模型

#### K-Means 聚类

K-Means 是一种基于距离的聚类算法，它将数据点划分为 K 个簇，使得同一簇内的数据点相似度较高，不同簇的数据点相似度较低。

```python
from sklearn.cluster import KMeans

# 创建K-Means模型实例，设置簇的数量为3
model = KMeans(n_clusters=3)
# 训练模型
model.fit(X)
# 获取每个样本所属的簇标签
labels = model.labels_
```

#### DBSCAN 密度聚类（Density-Based Spatial Clustering of Applications with Noise）

DBSCAN 是一种基于密度的聚类算法，它不需要事先指定簇的数量。该算法将数据空间中密度相连的数据点划分为一个簇，并将低密度区域的数据点视为噪声点。DBSCAN 适用于发现任意形状的簇，对于数据集分布不均匀、存在噪声的情况表现较好。

```python
from sklearn.cluster import DBSCAN

# 创建DBSCAN模型实例，设置邻域半径为0.5，最小样本数为5
model = DBSCAN(eps=0.5, min_samples=5)
# 训练模型
model.fit(X)
# 获取每个样本所属的簇标签，-1表示噪声点
labels = model.labels_
```

## 总结

Scikit-learn 功能强大，本文仅介绍了其基本使用方法。通过不断学习和实践，你可以利用它解决更复杂的机器学习问题，为数据分析和预测提供有力支持。希望本文能帮助你快速上手 Scikit-learn，开启机器学习之旅。

## 参考文档

[scikit-learn中文社区](https://scikit-learn.org.cn/)

[scikit-learn: machine learning in Python — scikit-learn 1.6.1 documentation](https://scikit-learn.org/stable/index.html)
