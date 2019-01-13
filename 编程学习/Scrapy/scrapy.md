sudo apt-get install python

pip install virtualenv

pip install -i https://pypi,douban.com/simple/ django

virtualenv scrapytest

source activate.bat 

## 基础知识
scrapy vs requests+beautifulsoup

静态网页
动态网页
webservice（restapi）

爬虫作用
1.搜索引擎--百度、google、垂直领域搜索引擎
2.推荐引擎
3.机器学习


## 正则表达时
1.特殊字符
^ 开始字符
$ 结尾字符
* 重复出现0次或多次
？非贪婪匹配（从左边开始匹配）
```python
import re
line="bobby123"
regex_str="^b.*"
if re.match(regex_str,line);
	print("yes")
```


