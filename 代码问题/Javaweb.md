# Javaweb
## java.lang.ClassNotFoundException: com.mysql.jdbc.Driver
解决方法：把mysql-connector-java-5.1.7-bin.jar导入到tomcat的lib目录下面就ok了，嘿……

## jsp中用<%@ include %>时，被包含文件出现乱码
解决方法：在被包含文件的开头指明使用字符集
```jsp
<%@ page language= "java" contentType="text/html;charset=UTF-8" %>
```

