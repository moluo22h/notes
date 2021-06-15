数据库设计

1. 是否冗余
2. 表之间的关系，表外父子关系（第3方表、父主键），表内父子关系
3. 字段数据类型
4. 字段长度



字段拆分原则





表分类原则

当两个表存在关系时



表A需要表B的信息。对于表A而言，是把表B当成模板表还是字典表？

把表B当成模板表：则表B直接复制表A的属性，不存在外键

把表B当成字典表：则表B中存在一个外键指向表A



冗余还是范式



# Mysql 长度字段解析

## 在聊Mysql长度问题之前，我们先需要了解以下两方面知识：

1. 位、字节、字符三者的区别

   位（bit）：二进制位。

   字节（byte）：1个byte由8个bit组成。

   字符：1个字符由1个或多个byte组成，根据编码方式不同，byte个数也不同。

   

2. MySQL 数据类型

   MySQL 数据类型可参考https://www.runoob.com/mysql/mysql-data-types.html



## 不同数据类型的length区别

- 对于数值类型

  TINYINT、SMALLINT、MEDIUMINT、INTEGER、和BIGINT，长度不生效。

  FLOAT、DOUBLE，由于长度太长， 并没有测试。

  DECIMAL（m，n），m为有效位数=整数位数+小数位数（也称为长度），n代表几位小数。



- 对于时间值类型

  DATETIME，长度代表yyyy-MM-hh HH:mm:ss.xxxxxx中x的位数，最多允许6位，微秒级别

  DATE、TIMESTAMP、TIME和YEAR，由于很少使用，并没有测试，后期补充。



- 对于字符串类型

  CHAR、VARCHAR，长度单位为字符，一个数字、一个字母、一个汉字均为一个字符。

  BINARY、VARBINARY、BLOB、TEXT、ENUM和SET，并没有测试，后期补充。







## 参考文档

[mysql数据库设计和优化](https://www.jianshu.com/p/23a36a453b56)