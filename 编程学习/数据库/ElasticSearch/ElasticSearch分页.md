# ElasticSearch分页

## from+size 实现分页

from表示从第几行开始，size表示查询多少条文档。from默认为0，size默认为10。

```json
GET /_search
{
    "from" : 0, "size" : 10,
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}
```

> 注意：from+size的大小不能超过index.max_result_window参数的设置值（默认为10000）。如果搜索size大于10000，需要设置index.max_result_window参数。但并不建议将index.max_result_window的值设置得很大，因为这将给ElasticSearch带来巨大性能开销，特别是在分布式情况下。

## Scroll

通过from+size获取数据的方式，我们只能获取到index.max_result_window设置值（默认10000）的数据量。想要获取大量数据怎么办呢？

ElasticSearch为我们提供了scroll API，通过scroll API我们可以获取大量的数据，甚至是所有数据。但scroll并不适合用来做实时搜索，同时对于contexts的代价是昂贵的。scroll更适用于后台批处理任务或数据迁移。

使用scroll 分为初始化和遍历两步

* 初始化：将所有符合搜索条件的搜索结果缓存起来，可以想象成快照。
* 遍历：从初始化形成的快照里取数据，因为数据来源是快照，所以scroll的数据并非实时数据。

1.初始化

```json
POST /twitter/_search?scroll=1m
{
    "size": 100,
    "query": {
        "match" : {
            "title" : "elasticsearch"
        }
    }
}
```

> 说明：
> 请求参数 scroll 表示暂存搜索结果的时间，即快照的生存时间，这个时间将下一次请求到来时被刷新。
> 请求将返回一个_scroll_id，_scroll_id 用来下次获取数据。

2.遍历：	

```json
POST /_search/scroll 
{
    "scroll" : "1m", 
    "scroll_id" : "DXF1ZXJ5QW5kRmV0Y2gBAAAAAAAAAD4WYm9laVYtZndUQlNsdDcwakFMNjU1QQ==" 
}
```

> 说明：
> 这里的 scroll_id 为上一次遍历取回的 _scroll_id 或初始化返回的 _scroll_id，却请求时必须携带scroll_id。
> 通过scroll_id，搜索时将不需要指定 index 和 type。

## search_after

Scroll 支持深度查询，但contexts的代价是昂贵的且不适用于实时用户请求。为此，ElasticSearch提供了search_after，search_after 提供了一个实时的光标来避免深度分页的问题，其思想是使用前一页的结果来帮助检索下一页。

使用search_after 需要使用一个字段作为排序字段，该字段的值具有唯一性、不重复性，推荐使用_uid 作为唯一值的排序字段

使用search_after步骤如下：

```json
GET twitter/_search
{
    "size": 10,
    "query": {
        "match" : {
            "title" : "elasticsearch"
        }
    },
    "sort": [
        {"date": "asc"},
        {"tie_breaker_id": "asc"}      
    ]
}
```

> 说明：
>
> 通过该命令可以获得一条返回记录，其中具有一组 sort values ，在我们使用search_after 时将会用到这组值。

```json
GET twitter/_search
{
    "size": 10,
    "query": {
        "match" : {
            "title" : "elasticsearch"
        }
    },
    "search_after": [1463538857, "654323"],
    "sort": [
        {"date": "asc"},
        {"tie_breaker_id": "asc"}
    ]
}
```

注意：search_after不能自由跳到一个随机页面，只能按照 sort values 跳转到下一页

## 总结

* 深度分页不管是关系型数据库还是Elasticsearch还是其他搜索引擎，都会带来巨大性能开销，特别是在分布式情况下。

* 对于深度分页我们是应该尽量避免的，比如很多业务都对页码有限制，当页码超过某个值再往后翻就不行了。 如 google 搜索 、百度搜索、github等均对页码做了限制。

* scroll 并不适合用来做实时搜索，而更适用于后台批处理任务即数据迁移。

* search_after不能自由跳到一个随机页面，只能按照 sort values 跳转到下一页。

## 参考文档

[Elasticsearch Reference](https://www.elastic.co/guide/en/elasticsearch/reference/6.6/index.html)