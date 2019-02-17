# servlet学习

##  servlet编程过程
//设置请求编码格式
//设置响应编码格式
//获取请求信息
//处理请求信息
//响应处理结果
​    // 直接响应
​    //请求转发
​    //重定向

## cookie
  * cookie产生的原因？
    http请求是一次性请求，但同一用户可能会通过http协议向服务器发送多次请求
    有需求，
    获取服务器上属于我的资源
    登陆时，请求中携带了用户账号和密码，可以获取到
    登陆之后呢，想要获取到也需要一个标志身份的标志位，cookie
    
      超市购物，购物卡
    cookie和session用于用户的状态管理
    简单的来说它们都只是http中的一个配置项，在Servlet规范中也只对应一个类而已；http对cookie的数量和大小有限制，而session不易于在很多的服务器中进行共享。
  * 什么是cookie？
                        浏览器端的数据存储技术。
    当一个用户通过http访问一个服务器，这个服务器会将一些key/value键值对返回到客户端浏览器，并给这些数据加上一些限制条件，在条件符合时这个用户下次访问这个服务器时，数据又被完整的带回给服务器。这些数据（key/value键值对就是cookie）
  * 怎么用cookie？
     cookie的创建和存储
 *              //创建cookie对象
 *              Cookie cookie = new Cookie("key","value"); 注意：不要带（[ ] ( ) = , " / ? @ : ;）
 *              //设置cookie（可选）
 *                  //设置有效期
 *                  cookie.setMaxAge(60*60*24); 
 *                  //设置有效路径
 *              //响应cookie给客户端
 *              response.addCookie(cookie);
 *    Cookie的获取
 *              //获取cookie的信息数据
  * 什么是session？
    有效路径设置，不是每个http请求到携带cookie（cookie容量下，详细信息服务器），有的界面又希望使用共享数据怎么办。
  * 怎么用session？

