# Logo区制作

## html代码

```html
    <div class="logo">
        <div class="logo-left">
            <img src="images/logo.jpg">
        </div>
        <div class="logo-right">
            <img src="images/tel.jpg">24小时服务热线：<span class="tel">123-456-7890</span>
        </div>
    </div><!--logo结束-->
```

## css样式

1. 设置logo区背景颜色为白色

   ```css
   .logo {
       height: 80px;
       background-color: white;
   }
   ```

   > 提示：如果不设置height属性，只设置background-color将不起作用。猜测div默认高度为0

2. 设置 logo-left,宽200px，左浮动；设置logo-right宽为300px，右浮动；

   ```css
   .logo-left {
       width: 200px;
       float: left;
   }
   
   .logo-right {
       width: 300px;
       float: right;
   }
   ```

3. 设置logo-left垂直居中,文本颜色为#8E8E8E

   ```css
   line-height: 80px;
   color: #8E8E8E;
   ```

4. 设置logo-left中的img垂直居中，右边距为10px

   ```css
   .logo-right img{
       vertical-align: middle;
       margin-right: 10px;
   }
   ```

   >  vertical-align 属性设置元素的垂直对齐方式。把此元素放置在父元素的中部vertical-align: middle;

5. 设置电话号码字体大小和颜色

   ```css
   .tel{
       font-size: 16px;
       color: red;
   }
   ```


