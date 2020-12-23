# swagger

swagger注解及其描述

| 注解               | 使用位置     | 描述                    |
| ------------------ | ------------ | ----------------------- |
| @Api               | 类           | 类的描述                |
| @ApiOperation      | 方法         | 方法的描述              |
| @ApiImplicitParams | 方法（参数） | @ApiImplicitParam的容器 |
| @ApiImplicitParam  | 方法（参数） | 方法参数的描述          |
| @ApiResponses      | 方法（响应） | @ApiResponse的容器      |
| @ApiResponse       | 方法（响应） | 方法响应的描述          |

> 若请求参数无法使用@ApiImplicitParam注解时，可使用@ApiModel替代

@ApiOperation的参数描述

| 参数       | 描述             | 示例               |
| ---------- | ---------------- | ------------------ |
| value      | 方法描述（简短） | 修改用户密码       |
| notes      | 方法描述（详细） | 根据用户id修改密码 |
| httpMethod | 方法请求方式     |                    |
| response   | 方法返回值类型   |                    |

@ApiImplicitParam的参数描述

| 参数         | 描述         | 示例                                                         |
| ------------ | ------------ | ------------------------------------------------------------ |
| name         | 参数名       | userName                                                     |
| value        | 参数描述     | 用户名                                                       |
| dataType     | 参数类型     | String                                                       |
| required     | 参数是否必须 | true：必须<br />false：非必须                                |
| defaultValue | 参数默认值   | 张三                                                         |
| paramType    | 参数位置     | header：放置于Header中，使用@RequestHeader获取<br />query：放置于param中，使用@RequestParam获取<br />path：放置于path中，使用@PathVariable获取<br />body：放置于boby中，使用@RequestBody获取<br />form：（后期补充） |

> paramType会影响swagger参数的位置，如果paramType指定的参数位置与方法实际参数位置不一致，通过swagger将无法接受到参数。

@ApiResponse的参数描述

| 参数     | 描述         | 示例     |
| -------- | ------------ | -------- |
| code     | 返回码       | 错误码   |
| message  | 返回信息     | 错误信息 |
| response | 抛出异常的类 |          |



- @ApiParam()

  name = “参数名称”
  value = “参数具体描述”
  required = “是否必须参数”