任何一个向Elasticsearch发起的HTTP请求都将有以下几个部分组成：

```sh
curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
```

其中，各变量说明如下：

<VERB>
The appropriate HTTP method or verb. For example, GET, POST, PUT, HEAD, or DELETE.
<PROTOCOL>
Either http or https. Use the latter if you have an HTTPS proxy in front of Elasticsearch or you use Elasticsearch security features to encrypt HTTP communications.
<HOST>
The hostname of any node in your Elasticsearch cluster. Alternatively, use localhost for a node on your local machine.
<PORT>
The port running the Elasticsearch HTTP service, which defaults to 9200.
<PATH>
The API endpoint, which can contain multiple components, such as _cluster/stats or _nodes/stats/jvm.
<QUERY_STRING>
Any optional query-string parameters. For example, ?pretty will pretty-print the JSON response to make it easier to read.
<BODY>
A JSON-encoded request body (if necessary).







```bash
curl -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe"
}
'
```





列出所有的索引

```bash
curl "localhost:9200/_cat/indices?v"
```

