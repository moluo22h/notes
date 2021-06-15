# IDEA如何一个窗口打开多个项目？

## 项目准备

1. 新建一个文件夹，将多个SpringBoot项目放置在该文件夹下

   ![image-20210423105734864](media/Idea如何一个窗口多个项目/image-20210423105734864.png)

## 打开项目

### 1. 点击Open

![image-20210423100144406](media/Idea如何一个窗口多个项目/image-20210423100144406.png)

### 2. 选择demo文件夹，点击OK打开

![image-20210423100703610](media/Idea如何一个窗口多个项目/image-20210423100703610.png)

### 3. 项目打开后发现，IDEA并未将demo1和demo2当作项目对待。

![image-20210423101211559](media/Idea如何一个窗口多个项目/image-20210423101211559.png)



## 配置项目结构

### 1. 点击`File`，选择`Project Structure`。

![image-20210423101352751](media/Idea如何一个窗口多个项目/image-20210423101352751.png)

### 2. 保证`Project name`的值为文件夹名demo，正常情况，打开后默认便是该值。

![image-20210423101445784](media/Idea如何一个窗口多个项目/image-20210423101445784.png)

### 3. 选择`Module`。

![image-20210423101530782](media/Idea如何一个窗口多个项目/image-20210423101530782.png)

### 4. 点击`+`号，选择`Import Module`，对项目进行导入

![image-20210423101709850](media/Idea如何一个窗口多个项目/image-20210423101709850.png)

### 5. 选择`demo1`项目中的`build.gradle`文件，点击`OK`

![image-20210423101933173](media/Idea如何一个窗口多个项目/image-20210423101933173.png)

### 6. 选择`use gradle 'wrapper' task configuration`，点击`OK`

![image-20210423102057498](media/Idea如何一个窗口多个项目/image-20210423102057498.png)

### 7. 可以发现demo1项目导入成功。

![image-20210423102159284](media/Idea如何一个窗口多个项目/image-20210423102159284.png)

### 8. 同理导入demo2。

![image-20210423102308913](media/Idea如何一个窗口多个项目/image-20210423102308913.png)

### 9. 点击OK

![image-20210423102350471](media/Idea如何一个窗口多个项目/image-20210423102350471.png)

### 10. 等待项目同步完成

![image-20210423102507982](media/Idea如何一个窗口多个项目/image-20210423102507982.png)

### 11. 可以发现demo1和demo2已被IDEA当作项目对待

![image-20210423102901002](media/Idea如何一个窗口多个项目/image-20210423102901002.png)

效果细节如下：

![image-20210423094916383](media/Idea如何一个窗口多个项目/image-20210423094916383.png)

![image-20210423095107458](media/Idea如何一个窗口多个项目/image-20210423095107458.png)

![image-20210423095223953](media/Idea如何一个窗口多个项目/image-20210423095223953.png)

![image-20210423095648812](media/Idea如何一个窗口多个项目/image-20210423095648812.png)

![image-20210423095807614](media/Idea如何一个窗口多个项目/image-20210423095807614.png)

# IDEA如何一个窗口创建多个项目？

## 前期准备

新建一个文件夹，名为demo，用于放置项目

## 打开文件夹

### 1. 点击Open

![image-20210423103756360](media/Idea如何一个窗口多个项目/image-20210423103756360.png)

### 2. 选择demo文件夹，点击OK打开

![image-20210423103907449](media/Idea如何一个窗口多个项目/image-20210423103907449.png)

### 3. 打开后发现，IDEA将demo文件夹当作项目对待。

![image-20210423103950300](media/Idea如何一个窗口多个项目/image-20210423103950300.png)

## 创建Module,每一个Module对应一个项目

### 1. 在demo上右键，选择`New`→`Module`，

![image-20210423104209555](media/Idea如何一个窗口多个项目/image-20210423104209555.png)

之后的行为和创建springBoot项目的方式一致，若你已熟悉，可跳过后续步骤。

### 2. 选择`Spring Initializr`

![image-20210423104311301](media/Idea如何一个窗口多个项目/image-20210423104311301.png)

### 3. 填写项目信息

Type选择`Gradle Project`

![image-20210423104519167](media/Idea如何一个窗口多个项目/image-20210423104519167.png)

### 4. 勾选Spring依赖

![image-20210423104619153](media/Idea如何一个窗口多个项目/image-20210423104619153.png)

### 5. 输入Module名称和选择项目存放位置

![image-20210423104658391](media/Idea如何一个窗口多个项目/image-20210423104658391.png)

### 6. 选择`use gradle 'wrapper' task configuration`，点击`OK`

![image-20210423104758255](media/Idea如何一个窗口多个项目/image-20210423104758255.png)

### 7. 等待demo1项目导入成功。

![image-20210423104847136](media/Idea如何一个窗口多个项目/image-20210423104847136.png)

### 8. 同理可创建demo2。