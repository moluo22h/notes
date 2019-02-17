# Thymeleaf

## Thymeleaf标志方言
<span th:text="...">
<span data-th-text="...">

Thymeleaf命名空间：xmlns:th="http://www.thymeleaf.org"

## 标准表达式
- 变量表达式
${...}
<span th:text="${user.name}">

- 消息表达式
#{...}
#{header.address.city}

- 选择表达式
*{...}
变量表达式+选择表达式

- 链接表达式
@{...}
相对../
服务器相对~
协议相对//
绝对http://

- 分段表达式
th:insert
th:replace

- 字面量
th:text="hello world"

- 判断
th:if=

- 算数
+ - * /

- 比较和等价
data-th-if
gt lt ge le 
eq ne

- 条件运算符
? :

- 无操作
"-"


## 设置属性值
- 设置任意属性值th:attr
th:attr="action=..."
th:attr="value=..."

- 设置值到指定的属性
th:action=...
th:value=...

- 固定值布尔属性
checked
hidden
readonly


## 迭代器
th:each=
th:each="book:${books}"

状态变量
index 
count
size
current
even/odd
first
last
${name:odd}


## 条件语句
th:if
th:unless
th:switch	th:case

## 模板布局
定义模板变量
- th:fragment
```html
<div th:fragment="copy"></div>
```
- id
```html
<div id=...></div>
```
引入模板变量
th:insert
th:replace
th:include

## 属性优先级
同一个标签中写入多个th:* ,
th:insert th:replace
th:eath
th:if
th:object
th:attr
th:value
th:text
th:remove


## 注释
标注html注释

解析器级别注释
<!--/* */-->

原型注释块
<!--/*/
/*/-->

## 内联
- 内联表达式
[[...]] th:text  会对字符转义
[(...)] th:utext
<p>the message is "[(${msg})]"</p>

- 禁用内联
th:inline="none"

- JavaScript内联

- css内联
<style th:inline="css">

## 基本对象
#ctx:上下文对象
#locale：
#param：用于检索
#session
# application：

# 上下文对象
# request
#session
#serveletContext

Thymeleaf与Spring Boot集成
依赖 spring-boot-starter-thymeleaf

//自定义thymleaf 和thymeleaf layout dialect 的版本
ext['thymeleaf.version']='3.0.0.RELEASE'
ext['themeleaf-layout-dialect.version']='2.2.0'


## Theymeleaf 实战
修改application.properties
spring.thymeleaf.encoding=utf-8
