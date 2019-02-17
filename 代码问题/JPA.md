# JPA

## com.fasterxml.jackson.databind.exc.InvalidDefinitionException
发生原因：使用了getOne（）方法
解决方法一： 使用findById（）方法代替getOne（）方法
解决方法二： 在对应的实体类上添加@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})注解
解决方法三： 在配置文件中添加spring.jackson.serialization.FAIL_ON_EMPTY_BEANS=false

