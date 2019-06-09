# ElasticSearch

## 索引结构设计

```json
{
    "mapping":{
        "house":{
            "dynamic":false,
            "properties":{
                "title":{
                    "type":"text",
                    "index":"analyzed"
                }
                ...
            }
        }
    }
}
```

中文分词 index：analyzed

type:keyword,text,integer,data,long

## 索引结构模板

```java
public class HouseIndexTemplate{
    private String title;
    ...
}
```

索引关键字统一定义

```java
public class HouseIndexKey{
    public static final String TITLE="title"
}
```

## 索引构建





## 搜索引擎

```java
public void query(){
    BoolQueryBuilder boolQuery=QueryBuilders,boolQuery();
    boolQuery.filter(QueryBuilders.termQuery(CITY_EN_NAME,rentSearch.getCityEnName()));
    SearchRequestBuilder requestBuilder=this.esClient.prepareSearch(INDEX_NAME)
        .serType(INDEX_TYPE)
        .setQuery(boolQuery)
        .addSort()
        .setFrom()
        .setSize()
}
```































## 中文分词

/_analyze?analyzer=stadard&pretty=true&text=Well,Wall is a handsome teacher

/_analyze?analyzer=stadard&pretty=true&text=瓦力是一个英俊的老师

elasticSearch默认分词是以每个“字”为单位的

elasticsearch-analysis-ik-5.6.1.zip

```json
{
    "title":{
        "type":"text",
        "index":"analyzed",
        "analyzer":"ik_smart",
        "search_analyzer":"ik_smart"
    }
}
```

## Search-as-your-type



