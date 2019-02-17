## 可用应用场景
- 海量数据分析引擎
- 站内搜索引擎
- 数据仓库

单实例配置文件(关联elasticsearch-head)
elasticsearch.yml
```yaml
http.cors.enabled: true
http.cors.allow-origin: "*"
```


主节点配置文件
elasticsearch.yml
```yaml
http.cors.enabled: true
http.cors.allow-origin: "*"

cluster.name: momo
node.name: master
node.master: true

network.host: 127.0.0.1
```

子节点配置文件
elasticsearch.yml
```yaml
cluster.name: momo
node.name: slave1

network.host: 127.0.0.1
http.port: 8200

discovery.zen.ping.unicast.hosts: ["127.0.0.1"]
```


集群和节点

索引：含有相同属性的文档集合
类型：索引可以定义一个或多个类型，文档必须属于一个类型
文档：文档是可以被索引的基本数据单位

database table 记录

分片：每个索引都有多个分片，每个分片是一个Lucence索引
备份：拷贝一份分片就可以完成了分片的备份

5个分片一个备份


## elasticsearch使用
api基本格式 http://<ip>:<port>/<索引>/<类型>/<文档id>
get/put/post/delete

非结构的创建
结构化创建

## 创建索引
```json
{
	//索引的配置
    "settings":{
        "number_of_shards":3,
        "number_of_replicas": 1
    },
    //索引映射定义
    "mapping":{
        "man":{
            "properties":{
                "name":{
                    "type":"text"
                },
                "country":{
                    "type":"keyword"
                },
                "age":{
                    "type":"integer"
                },
                "data":{
                    "type":"data",
                    "format":"yyyy-MM-dd HH:mm:ss || yyyy-MM-dd || epoch-millis"
                }
            }
        },
        "woman":{
            
        }
    }
}
```

### 插入

指定文档id插入
put方法 localhost:9200/people/man/1
```json
{
    "name":"瓦力",
    "country":"China",
    "age":30,
    "data":"1987-03-07"
}
```


自动产生文档id插入
post方法：localhost:9200/people/man
```json
{
    "name":"卡里",
    "country":"China",
    "age":18,
    "data":"1987-03-09"
}
```

### 修改
- 直接修改文档
post方法 localhost:9200/people/man/1/_update
```json
{
    "doc":{
        "name":"谁是瓦力"
    }
}
```

- 脚本修改文档
post方法 localhost:9200/people/man/1/_update
```json
{
    "script":{
        "lang":"painless",
        "inline":"ctx._source.age+=params.age",
        "params":{
            "age":100
        }
    }
}
```

### 删除
- 删除文档
delete方法 localhost:9200/people/man/1

- 删除索引
head中动作：删除
delete方法 localhost:9200/people

### 查询
简单查询
get方法 localhost:9200/book/nover/1

条件查询
post方法 localhost:9200/book/_search
查询所有
```json
{
    "query":{
        "match_all":{}
    },
    "from":1,
    "size":1
}
```
查询标题中包含Elasticsearch，降序排序
```json
{
    "query":{
        "match":{
            "title":"Elasticsearch"
        }
    },
    "sort":[
        {"publish_data":{"order":"desc"}}
    ]
    "from":1,
    "size":1
}
```
聚合查询
书籍字数聚合
```json
{
    "aggs":{
        "group_by_word_count":{
            "terms":{
                "field"："word_count"
            }
        }
        "group_by_publish_data":{
            "terms":{
                "field"："publish_data"
            }
        }
}
```

```json
{
    "aggs":{
        "grades_word_count":{
            "stats":{
                "field":"word_count"
            }
        }
    }
}
```
```json
{
    "aggs":{
        "grades_word_count":{
            "stats":{
                "min":"word_count"
            }
        }
    }
}
```

## 高级查询
子条件查询 ：特定字段查询所指特定值
复合条件查询：以一定的逻辑组合子条件查询

子条件查询
Query context
常用查询
全文本查询 ：针对文本类型数据
字段级别查询 ：针对结构化数据，如数字、日期等。
post方法：localhost:9200/book/_search
```json
{
    "query":{
        "match":{
            "author":"瓦力"
        }
    }
}
```
习语匹配
```json
{
    "query":{
        "match_phrase":{
            "author":"瓦力"
        }
    }
}
```
作者和标题都有瓦力的信息
```json
{
    "query":{
        "multi_match":{
            "query":"瓦力",
            "fields":["author","title"]
        }
    }
}
```
语法查询
{
​    "query":{
​        "query_string":{
​            "query":"(ElasticSearch AND 大法) OR Python"
​        }
​    }
}


字段级别查询
```json
{
    "query":{
        "term":{
            "word_count":1000
        }
    }
}
```
范围查询
```json
{
    "query":{
        "range":{
            "word_count":{
                "gte":1000,
                "lte":2000
            }
        }
    }
}
```
```json
{
    "query":{
        "range":{
            "publish_date":{
                "gte":"2017-01-01",
                "lte":"now"
            }
        }
    }
}
```
### Filter context
数据过滤，会有数据缓存，只有结果，没有程度
```json
{
    "query":{
        "bool":{
            "filter":{
                "term":{
                    "word_count":1000
                }
            }
        }
    }
}
```
### 复合查询
常用查询
- 固定分数查询
- 布尔查询
- ...more

固定分数查询
post方法：localhost:9200/_search
```json
{
    "query"{
        "constant_score":{
            "filter":{
                "match":{
                    "title":"ElasticSearch"
                }
            },
            "boost":2
        }
    }
}
```
布尔查询
```json
{
    "query"{
        "bool":{
            "should":[
                {
                    "match":{
                        "author":"瓦力"
                    }
                },{
                    "match":{
                        "title":"ElasticSearch"
                    }
                }
            ]
        }
    }
}
```
```json
{
    "query"{
        "bool":{
            "must":[
                {
                    "match":{
                        "author":"瓦力"
                    }
                },{
                    "match":{
                        "title":"ElasticSearch"
                    }
                }
            ],
            "filter":[
                {
                    "term":{
                        "word_count":1000
                    }
                }
            ]
        }
    }
}
```


```json
{
    "query"{
        "bool":{
            "must_not":{
                "term":{
                    "author":"瓦力"
                }
            }
        }
    }
}
```






