## 文件的编码
UTF-8
ANSI
编码问题
File类的使用

转换成字节序列使用的是项目默认的编码gbk
s.getBytes("gbk")
gbk编码中文占用两个字节，英文占用一个字节

s.getBytes("utf-8")
utf-8编码中文占用三个字节，英文占用一个字节

java是双字节编码uft-16be
s.getBytes("utf-16be")
utf-16be编码中文占用两个字节，英文占用两个字节

当你的字节序列是某种编码时，这个时候想把字节序列变成字符串，也需要用这种编码方式，否则会出现乱码
new String(bytes,"utf-16be")

```
String s
byte[] bytes=s.getBytes();
for(byte b:bytes){
    System.out.println(Integet.toHexString(b&0xff))
}
```


文本文件就是字节序列，可以时任意编码的字节序列
如果我们在中文机器上直接创建文本文件，那么该文本文件只认识ansi编码


## File类的常用api
java.io.File类用于表示文件（目录）
File类只用于表示文件（目录）的信息（名称、大小等），不能用于文件内容的访问


new File("E:\\javaio");
new File("E:/javaio");
new File("E:"+File.separator+"javaio");
文件夹操作api
| 操作 | 方法 |
| ------ | ------ |
| 创建 | 创建单极目录 file.mkdir();创建多级目录file.mkdirs()|
| 获取信息 | |
| 删除 | |

```java
File file=new File("E:\\javaio")
file.exists() 文件是否存在

if(!file.exists()){
    file.mkdir();
}

file.mkdir() 穿件文件夹
file.delete() 删除文件/文件夹
```
使用分隔符
new File("e:"+File.separator);


是否是目录
file.isDirectory() 
file.isFile() 是否是文件
```java
File file=new File("e:/javaio/日记1.txt)
if(file.exists()){
    file.createNewFile();
}
```
File file=new File("e:/javaio",“日记.txt")
直接打印file，为file.toString()的内容,为文件的绝对路径
file.getAbsolutePath()
file.getName() 返回文件/文件夹的名字
file.getParent()返回父目录
file.mkdirs()创建多级目录

## 遍历目录
FileUtils.java
列出File的一些常用操作比如过滤，遍历等操作
```java
Public class FileUtils{
    public statis void ListDirectory(File dir){
        if(!dir.exists()){
            throw new IllegalArgumentException(”)
        }
        if(!dir.isDirectory()){
            throw new IllegalArgumentException("")
        }
        String[] list=dir.list();当前目录下所有文件/文件夹名（不包括子目录）
        如果要遍历子目录下的内容就需要构成File对象并做递归操作
        File[] files=dir.listFiles();//返回的是直接子目录/文件的抽象
    }
}

```

## RandomAccessFile基本操作
java提供的对文件内容的访问，既可以读文件，也可以写文件。
支持随机访问文件，可以访问文件的任意位置

1. java文件模型
在硬盘上的文件是byte byte byte存储的，是数据的集合

2. 打开文件
用两种模式“rw”(读写) “r"（只读）
new RandomAccessFile(file,"rw")
文件指针，打开文件时指针在开头 pointer=0；

3. 写方法
randomAccessFile.write(int) 只写一个字节（后8位），同时指针指向下一个位置，准备再次写入
读写一个int类型（32位）的数据，需要读4次

4. 读方法
reaf() 读一个字节

5. 文件读写完成以后一定要关闭（Oracle官方说明）

new File("demo")
会在程序的根目录里创建

randomAccessFile.getFilePointer（）获取指针的位置

写入一个int类型数据
int i=0x7fffffff;
用write方法每次只能写一个字节，如果要把i写进去就得写4次
randomAccessFile.write(i>>>24); //右移24位，写高8位
randomAccessFile.write(i>>>16);
randomAccessFile.write(i>>>8);
randomAccessFile.write(i);

或使用writeInt(i);

读文件，必须把指针移到头部
randomAccessFile.seek(0)
一次性读取，把文件中得内容都读到字节数组中
byte[] buf=new byte[randomAccessFile.length]
raf.read(buf)


字节流之文件输入流
FileInputStream
Io流（输入流，输出流）
字节流，字符流
1. 字节流

1）InputStream、OutputStream
InputStream抽象了应用程序读取数据得方式
OutputStream抽象了应用程序读取数据得方式

2）EOF=End 读到-1就读到结尾

3）输入流 基本方法
int b=in.read();读取一个字节无符号填充到int低8位。-1是EOP
in.read(byte[] buf) 读取数据填充到字节数组buf
in.read(byte[] buf, int start ,int size)读取数据到字节数组buf，从buf得start位置开始存放size长度得数据

4)输出流基本方法
out.write(int b)写出一个byte到流，b的低8位
out.write(byte[] buf) 将buf字节数组都写入到流
out.write(byte[] buf, int start,int size) 字节数组buf从start位置开始写size长度的字节到流

5）FileInputStream 具体实现了在文件上读取数据
```java
读取指定文件内容，按照16进制输出到控制台，并且每输出10个byte换行
public static void printHex（String fileName）{
    FileInputStream in=new FileInputStream（fileName）;
    int b;
    int i=1;
    while((b=in.read())!=-1){
        System.out.print(Integer.toHexString(b)+"");
        if(i++%10==0){
            System.out.println()
        }
    }
    in.close();
}
```

## 序列化基本操作

对象的序列化，反序列化
1）对象序列化，就是将Object转化成byte序列，反之叫对象的反序列化
2）序列化流（ObjectOutputStream），是过滤流  writeObject；反序列化流（ObjectInputStream） readObject
3）序列化接口（Serializable）
对象必须实现序列化接口，才能进行序列化，否则将出现异常
这个接口，没用任何方法，只是一个标准

private transient int stuage； //该元素不会进行jvm默认的序列化，但可以自己完成这个元素的序列化
网络中中不需要传输的字段可以用transient修饰

ArrayList

private void writeObject(){}
s.defaultwriteObject();
s.wreteInt(stuage)
}
s.re

分析Arraylist中序列









