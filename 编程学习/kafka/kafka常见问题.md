问题：

```bash
[2023-12-19 07:09:49,462] ERROR Exiting Kafka due to fatal exception (kafka.Kafka$)
java.lang.ClassNotFoundException: kafka.security.auth.SimpleAclAuthorizer
	at java.net.URLClassLoader.findClass(URLClassLoader.java:387)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:418)
	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:352)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:348)
	at org.apache.kafka.common.utils.Utils.loadClass(Utils.java:417)
	at org.apache.kafka.common.utils.Utils.newInstance(Utils.java:406)
	at kafka.security.authorizer.AuthorizerUtils$.createAuthorizer(AuthorizerUtils.scala:31)
	at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1583)
	at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1394)
	at kafka.Kafka$.buildServer(Kafka.scala:67)
	at kafka.Kafka$.main(Kafka.scala:87)
	at kafka.Kafka.main(Kafka.scala)
```

解决方式：[kafka启动报错：java.lang.ClassNotFoundException:kafka.security.auth.SimpleAclAuthorizer-CSDN博客](https://blog.csdn.net/ximenjianxue/article/details/132588230)

