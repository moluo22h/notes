# Postman使用
## 发送消息体到spring boot后台
1. 请求头添加：Content-Type：application/json键值对
2. 请求体：选择raw并选择Json（application/json）
3. 消息体中发送需要发送的json数据，如：
	```json
	{"name":"zoos","description":""}//消息格式
	```