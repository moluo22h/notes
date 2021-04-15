## 百度网盘视频在线倍速播放

### 老方法

```js
videojs.getPlayers("video-player").html5player.tech_.setPlaybackRate(此处填入加速倍数)
videojs.getPlayers("video-player").html5player.tech_.setPlaybackRate(1.5)
```

### 新方法

最近，百度网盘网站更新，导致以上老方法不再生效。

其原因是百度网盘使用了[Shadow DOM](https://developer.mozilla.org/zh-CN/docs/Web/Web_Components/Using_shadow_DOM)技术，百度网盘将网页的播放器封装成了一个组件放入到了 Shadow Root 中，而普通的插件是无法通过正常方式访问到里面播放器的video标签来调节变速的；

但shadow root中的内容并不是完全不能访问，通过其提供的接口或者网站的框架通过hook方式截取事件可操作变速。

**解决**：

现阶段很多插件和脚本可能都没有实现。你可以向这些插件或脚本作者提交该问题，请求加入支持。

若你对前端较为熟悉，也可参考以下链接自行解决：[百度云shadow-root内的video倍速播放](https://www.cnblogs.com/Dmail/p/13200837.html)

