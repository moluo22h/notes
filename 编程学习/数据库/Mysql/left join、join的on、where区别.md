# mysql之left join、join的on、where区别

原文地址：[mysql之left join、join的on、where区别看这篇就懂_left join on where-CSDN博客](https://blog.csdn.net/weixin_44981707/article/details/110739121)

## 前言

  对于外连接查询，我们都知道驱动表和被驱动表的关联关系条件我们放在 on后面，如果额外增加对驱动表过滤条件、被驱动表过滤条件，放 on 或者 where 好像都不会报错，但是得到的结果集确是不一样的。

  网上大量关于left join、join的on、where区别其实很多都是错误，本文开始揭晓其中区别所在，该如何使用。

## 讲解

### 1.准备工作

  建表语句

```mysql
CREATE TABLE `t_students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `gender` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8

CREATE TABLE `t_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8
```

  表数据

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163510708.png#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163520202.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDk4MTcwNw==,size_16,color_FFFFFF,t_70#pic_center)

### 2. Join 连接on、where区别

sql如下：

```mysql
SELECT * FROM `t_students` ts JOIN `t_classes` tc ON ts.`class_id` = tc.`id`;
1
```

  执行 `explain extended + sql;` 命令

| select_type | table | type | possible_keys | key    | key_len | ref    | rows | Extra                          |
| ----------- | ----- | ---- | ------------- | ------ | ------- | ------ | ---- | ------------------------------ |
| SIMPLE      | tc    | ALL  | (NULL)        | (NULL) | (NULL)  | (NULL) | 11   |                                |
| SIMPLE      | ts    | ALL  | PRIMARY       | (NULL) | (NULL)  | (NULL) | 5    | Using where; Using join buffer |

执行 `show warnings;` (该命令可以查看优化器优化后真正执行的[sql语句](https://so.csdn.net/so/search?q=sql语句&spm=1001.2101.3001.7020))

```mysql
select `mytest`.`ts`.`id` AS `id`,`mytest`.`ts`.`class_id` AS `class_id`,`mytest`.`ts`.`name` AS `name`,`mytest`.`ts`.`gender` AS `gender`,`mytest`.`tc`.`id` AS `id`,`mytest`.`tc`.`name` AS `name` 

from `mytest`.`t_students` `ts` join `mytest`.`t_classes` `tc` 

where (`mytest`.`tc`.`id` = `mytest`.`ts`.`class_id`)
```

  **分析**：`show warnings`展示了优化后的语句，可以发现 on 连接条件被转化为 where 过滤条件。更多案例，可以自己去测试，on 都会转化为 where

  **结论**：对于Join连接，on和where其实是一样的，经过InnoDB优化后，on连接条件会转化为where。

### 3. left join之on、where区别

#### 3.1 驱动表之on、where区别

  sql如下：

```mysql
SELECT * FROM `t_students` ts 
LEFT JOIN `t_classes` tc ON ts.`class_id` = tc.`id` AND ts.`gender` = 'M';
```

执行 `explain extended + sql;`

| select_type | table | type   | possible_keys | key     | key_len | ref                | rows | Extra |
| ----------- | ----- | ------ | ------------- | ------- | ------- | ------------------ | ---- | ----- |
| SIMPLE      | ts    | ALL    | (NULL)        | (NULL)  | (NULL)  | (NULL)             | 11   |       |
| SIMPLE      | tc    | eq_ref | PRIMARY       | PRIMARY | 4       | mytest.ts.class_id | 1    |       |

  执行 `show warnings;`

```mysql
select `mytest`.`ts`.`id` AS `id`,`mytest`.`ts`.`class_id` AS `class_id`,`mytest`.`ts`.`name` AS `name`,`mytest`.`ts`.`gender` AS `gender`,`mytest`.`tc`.`id` AS `id`,`mytest`.`tc`.`name` AS `name` 

from `mytest`.`t_students` `ts` left join `mytest`.`t_classes` `tc` 

on(((`mytest`.`ts`.`class_id` = `mytest`.`tc`.`id`) and (`mytest`.`ts`.`gender` = 'M'))) 

where 1
```

结果集：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163535729.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDk4MTcwNw==,size_16,color_FFFFFF,t_70#pic_center)

  **分析**：从结果集来看，ts.gender = ‘M’ 并未生效。为什么？

  从 explian 分析看出，ts 作为驱动表，做全表扫描，然后把查询到的每条记录的 `ts.class_id`、`ts.gender= 'M'` （也就是 on 条件里面的）作为条件让被驱动表tc 做单表查询（ts有多少条记录，单表查询多少次）得到结果集。

**结论**：left join 连接 on连接条件是给被驱动表用的，`ts.gender = 'M'` 放在 on连接条件里面，对驱动表查询是无效的，仅在连接被驱动表时生效，这不是我们想要的结果。

  那我们应该怎么改sql，让 `ts.gender = 'M'` 对驱动表生效呢？

修改后的 sql 如下：

```mysql
SELECT * FROM `t_students` ts LEFT JOIN `t_classes` tc
ON ts.`class_id` = tc.`id` WHERE ts.`gender` = 'M';
```

  执行`explain extended + sql;`

| select_type | table | type   | possible_keys | key     | key_len | ref                | rows | Extra       |
| ----------- | ----- | ------ | ------------- | ------- | ------- | ------------------ | ---- | ----------- |
| SIMPLE      | ts    | ALL    | (NULL)        | (NULL)  | (NULL)  | (NULL)             | 11   | Using where |
| SIMPLE      | tc    | eq_ref | PRIMARY       | PRIMARY | 4       | mytest.ts.class_id | 1    |             |

可以看出，ts表的 Extra 使用了 Using where

  执行 `show warnings;`

```mysql
select `mytest`.`ts`.`id` AS `id`,`mytest`.`ts`.`class_id` AS `class_id`,`mytest`.`ts`.`name` AS `name`,`mytest`.`ts`.`gender` AS `gender`,`mytest`.`tc`.`id` AS `id`,`mytest`.`tc`.`name` AS `name` 

from `mytest`.`t_students` `ts` left join `mytest`.`t_classes` `tc`

on((`mytest`.`tc`.`id` = `mytest`.`ts`.`class_id`)) 

where (`mytest`.`ts`.`gender` = 'M')
```

结果集：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163548986.png#pic_center)

  **分析**：

  从 explian 分析看出，ts作为驱动表，把 `ts.gender = 'M'` 作为条件做全表扫描，然后把查询到的每条记录的 `ts.class_id`（也就是 on连接条件）作为条件让被驱动表tc 做单表查询（ts有多少条记录，单表查询多少次）得到结果集。

可以看出， `ts.gender = 'M'` 放在where条件里面，驱动表做全表扫描时会带上where条件。

  **结论**：对于驱动表，需要加针对驱动表的过滤条件，我们应该放在 where条件而不是 on条件

#### 3.2 被驱动表之on、where区别

sql如下：

```mysql
SELECT * FROM `t_students` ts LEFT JOIN `t_classes` tc
ON ts.`class_id` = tc.`id` AND tc.`name` IN ( '二班', '三班');
```

  执行 `explain extended + sql;`

| select_type | table | type   | possible_keys | key     | key_len | ref                | rows | Extra |
| ----------- | ----- | ------ | ------------- | ------- | ------- | ------------------ | ---- | ----- |
| SIMPLE      | ts    | ALL    | (NULL)        | (NULL)  | (NULL)  | (NULL)             | 11   |       |
| SIMPLE      | tc    | eq_ref | PRIMARY       | PRIMARY | 4       | mytest.ts.class_id | 1    |       |

执行 `show warnings;`

```mysql
select `mytest`.`ts`.`id` AS `id`,`mytest`.`ts`.`class_id` AS `class_id`,`mytest`.`ts`.`name` AS `name`,`mytest`.`ts`.`gender` AS `gender`,`mytest`.`tc`.`id` AS `id`,`mytest`.`tc`.`name` AS `name` 

from `mytest`.`t_students` `ts` left join `mytest`.`t_classes` `tc` 

on(((`mytest`.`ts`.`class_id` = `mytest`.`tc`.`id`) and (`mytest`.`tc`.`name` in ('二班','三班')))) 

where 1
```

  结果集：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163601274.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDk4MTcwNw==,size_16,color_FFFFFF,t_70#pic_center)

  **分析**：

  从 explian 分析看出，ts 作为驱动表，做全表扫描，然后把查询到的每条记录的 `ts.class_id`、 `tc.name in ('二班','三班')` （也就是 on条件）作为条件让被驱动表tc 做单表查询（ts有多少条记录，单表查询多少次）得到结果集。

  假如：被驱动表的过滤条件放在 where 而不是 on呢，请看如下sql：

```mysql
SELECT * FROM `t_students` ts LEFT JOIN `t_classes` tc
ON ts.`class_id` = tc.`id` WHERE tc.`name` IN ( '二班', '三班');
```

  执行 `explain extended + sql;`

| select_type | table | type | possible_keys | key    | key_len | ref    | rows | Extra                          |
| ----------- | ----- | ---- | ------------- | ------ | ------- | ------ | ---- | ------------------------------ |
| SIMPLE      | ts    | ALL  | (NULL)        | (NULL) | (NULL)  | (NULL) | 11   |                                |
| SIMPLE      | tc    | ALL  | PRIMARY       | (NULL) | (NULL)  | (NULL) | 5    | Using where; Using join buffer |

  执行 `show warnings;`

```mysql
select `mytest`.`ts`.`id` AS `id`,`mytest`.`ts`.`class_id` AS `class_id`,`mytest`.`ts`.`name` AS `name`,`mytest`.`ts`.`gender` AS `gender`,`mytest`.`tc`.`id` AS `id`,`mytest`.`tc`.`name` AS `name` 

from `mytest`.`t_students` `ts` join `mytest`.`t_classes` `tc` 

where ((`mytest`.`tc`.`id` = `mytest`.`ts`.`class_id`) and (`mytest`.`tc`.`name` in ('二班','三班')))
```

  仔细看这里，left join连接变成了 join连接

  结果集：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163611877.png#pic_center)

  **分析**：

  从 `show warnings` 分析看出，如果被驱动表有过滤条件在 where，那么 left join 会失效，会被优化成 join 连接。所以，被驱动表的过滤条件应该放在 on而不是 where

### 4. 附加

  网上有种说法：left join连接 on会先生成虚拟表，然后再经过where条件过滤生成结果集。

  这种说法是错误的！

  验证：

  sql如下：

```mysql
SELECT * FROM `t_classes` tc LEFT JOIN `t_students` ts 
ON ts.`class_id` = tc.`id` WHERE ts.id = NULL
```

- 虚拟表生成：

```mysql
SELECT * FROM `t_classes` tc LEFT JOIN `t_students` ts 
ON ts.`class_id` = tc.`id`
```

  结果集如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163622392.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDk4MTcwNw==,size_16,color_FFFFFF,t_70#pic_center)

- 再经过

```mysql
WHERE ts.id = NULL
```

  生成结果集，应该如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210412163632290.png#pic_center)

  然后我们执行这条sql 生成的结果集却是如下所示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/2021041216364836.png#pic_center)

  原因：left join 被优化成了 join。