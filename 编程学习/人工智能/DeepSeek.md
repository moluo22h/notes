# DeepSeek 本地部署指南

## 引言
在人工智能飞速发展的今天，大语言模型的应用越来越广泛。DeepSeek 作为一款强大的大语言模型，具备出色的语言理解和生成能力。然而，许多用户希望能够在本地部署 DeepSeek，以实现更高的隐私性、更低的延迟和更好的定制化。本文将为你详细介绍 DeepSeek 本地部署的全过程，帮助你轻松在本地环境中使用 DeepSeek。

## 硬件要求

DeepSeek 不同参数版本介绍：

| 模型参数规模      | 典型用途                 | CPU 建议                                 | GPU 建议                                        | 内存建议 (RAM) | 磁盘空间建议      | 适用场景                          |
| ----------------- | ------------------------ | ---------------------------------------- | ----------------------------------------------- | -------------- | ----------------- | --------------------------------- |
| **1.5b (15亿)**   | 小型推理、轻量级任务     | 4核以上 (Intel i5 / AMD Ryzen 5)         | 可选，入门级 GPU (如 NVIDIA GTX 1650, 4GB 显存) | 8GB            | 10GB 以上 SSD     | 小型 NLP 任务、文本生成、简单分类 |
| **7b (70亿)**     | 中等推理、通用任务       | 6核以上 (Intel i7 / AMD Ryzen 7)         | 中端 GPU (如 NVIDIA RTX 3060, 12GB 显存)        | 16GB           | 20GB 以上 SSD     | 中等规模 NLP、对话系统、文本分析  |
| **14b (140亿)**   | 中大型推理、复杂任务     | 8核以上 (Intel i9 / AMD Ryzen 9)         | 高端 GPU (如 NVIDIA RTX 3090, 24GB 显存)        | 32GB           | 50GB 以上 SSD     | 复杂 NLP、多轮对话、知识问答      |
| **32b (320亿)**   | 大型推理、高性能任务     | 12核以上 (Intel Xeon / AMD Threadripper) | 高性能 GPU (如 NVIDIA A100, 40GB 显存)          | 64GB           | 100GB 以上 SSD    | 大规模 NLP、多模态任务、研究用途  |
| **70b (700亿)**   | 超大规模推理、研究任务   | 16核以上 (服务器级 CPU)                  | 多 GPU 并行 (如 2x NVIDIA A100, 80GB 显存)      | 128GB          | 200GB 以上 SSD    | 超大规模模型、研究、企业级应用    |
| **671b (6710亿)** | 超大规模训练、企业级任务 | 服务器级 CPU (如 AMD EPYC / Intel Xeon)  | 多 GPU 集群 (如 8x NVIDIA A100, 320GB 显存)     | 256GB 或更高   | 1TB 以上 NVMe SSD | 超大规模训练、企业级 AI 平台      |

根据你本地电脑的配置选择合适的版本，在如下示例中，我们将选用 `1.5b`这个版本。

## 本地部署步骤
### 1. 安装 Ollama 框架

Ollama 是一个可以在本地轻松运行大语言模型的工具，它简化了模型的下载、部署和使用过程，让开发者和普通用户能够更便捷地在本地使用各类大语言模型。

Ollama 支持多种操作系统，如 `macOS`、`Linux` 和 `Windows`。用户可以根据自己的系统类型，从[官方网站](https://ollama.com/)或相关的软件仓库下载安装包，按照安装向导的提示进行安装。

对于`Linux`操作系统，可使用如下命令进行安装，其他操作系统，请参考[Ollama官网](https://ollama.com/)

```bash
# curl -fsSL https://ollama.com/install.sh | sh
>>> Installing ollama to /usr
>>> Downloading Linux amd64 bundle
######################################################################## 100.0%
>>> Creating ollama user...
>>> Adding ollama user to video group...
>>> Adding current user to ollama group...
>>> Creating ollama systemd service...
>>> Enabling and starting ollama service...
Created symlink from /etc/systemd/system/default.target.wants/ollama.service to /etc/systemd/system/ollama.service.
>>> The Ollama API is now available at 127.0.0.1:11434.
>>> Install complete. Run "ollama" from the command line.
```

> 提示：Ollama的安装包大概有700M左右，下载耗时可能较长。

等待下载安装完成后，可通过命令`ollama -v`查看ollama版本，以验证是否正确安装

```bash
# ollama -v
ollama version is 0.5.7
```

如果显示 `Ollama`版本号，说明安装成功。

### 2. 安装DeepSeek模型

deepseek-r1版本包含：`1.5b`、`7b`、`8b`、`14b`、`32b`、`70b`、`671b`。目前Ollama以实现全面支持，详见：[ollama模型仓库 - deepseek-r1](https://ollama.com/library/deepseek-r1)

根据你本地电脑的配置选择合适的版本，例如我们选择 `1.5b`这个版本，运行代码如下：

```bash
# ollama run deepseek-r1:1.5b
pulling manifest 
pulling aabd4debf0c8... 100%  1.1 GB                         
pulling 369ca498f347... 100%  387 B                         
pulling 6e4c38e1172f... 100%  1.1 KB                         
pulling f4d24e9138dd... 100%  148 B                  
pulling a85fe2a2e58e... 100%  487 B                         
verifying sha256 digest 
writing manifest 
success 
```

等待安装完成后，就可以愉快的在本地使用大模型了，比如问问它是谁：

```bash
>>> 你是谁？
<think>

</think>

您好！我是由中国的深度求索（DeepSeek）公司开发的智能助手DeepSeek-R1。如您有任何任何问题，我会尽我所能为您提供帮助。
```

### 3. 安装AI客户端工具

如果你觉得，用命令行对话不是很方便，可以使用一些 UI 工具来和 deepseek 进行交互。常用的工具有：

| 工具                                    | 描述                                                         |
| --------------------------------------- | ------------------------------------------------------------ |
| [Chatbox](https://chatboxai.app/zh)     | 一个支持多种流行LLM模型的桌面客户端，可在 Windows、Mac 和 Linux 上使用 |
| [Cherry Studio](https://cherry-ai.com/) | 一款为创造者而生的桌面版 AI 助手                             |
| [AnythingLLM](https://anythingllm.com/) | 一款全方位AI应用程序。与您的文档聊天，使用AI代理，高度可配置，多用户，无需繁琐的设置。 |

或者你可以探索更多更好用的工具，适合自己使用习惯就行。在附录中，我们为你演示Cherry Studio的使用示例。

## 附录

#### Cherry Studio使用示例

1. 下载并安装[Cherry Studio](https://cherry-ai.com/download)。

![image-20250212190856896](D:\user\person\notes\编程学习\人工智能\assets\image-20250212190856896.png)

2. 运行[Cherry Studio](https://cherry-ai.com/download)，你将看到如下页面。



![image-20250212183518549](D:\user\person\notes\编程学习\人工智能\assets\image-20250212183518549.png)

3. 点击设置，模型服务选择Ollama，填写基本信息。

![image-20250212185455332](D:\user\person\notes\编程学习\人工智能\assets\image-20250212185455332.png)

4. 添加模型，模型ID根据实际部署情况填写，这里我们使用`deepseek-r1:1.5b`。

![image-20250212185548569](D:\user\person\notes\编程学习\人工智能\assets\image-20250212185548569.png)

5. 完成添加，便可以在如下页面看到模型列表。若你部署了多个版本的deepseek，可继续添加。

![image-20250212185615267](D:\user\person\notes\编程学习\人工智能\assets\image-20250212185615267.png)

6. 切换会对话菜单，点击切换模型按钮

![image-20250212190026159](D:\user\person\notes\编程学习\人工智能\assets\image-20250212190026159.png)

7. 选择新添加的`Ollama`分组下的`deepseek-r1:1.5b`

![image-20250212190101070](D:\user\person\notes\编程学习\人工智能\assets\image-20250212190101070.png)

8. 愉快的开始提问吧

![image-20250212190138663](D:\user\person\notes\编程学习\人工智能\assets\image-20250212190138663.png)

## 常见问题

### 1. Cherry Studio无法连接Ollama

默认情况下，Ollama 服务仅在本地运行，不对外提供服务。要使 Ollama 服务能够对外提供服务，你需要设置以下两个环境变量：

```bash
OLLAMA_HOST=0.0.0.0
OLLAMA_ORIGINS=*
```

#### 在 MacOS 上配置

1. 打开命令行终端，输入以下命令：

   ```bash
   launchctl setenv OLLAMA_HOST "0.0.0.0"
   launchctl setenv OLLAMA_ORIGINS "*"
   ```

2. 重启 Ollama 应用，使配置生效。

#### 在 Windows 上配置

在 Windows 上，Ollama 会继承你的用户和系统环境变量。

1. 通过任务栏退出 Ollama。

2. 打开设置（Windows 11）或控制面板（Windows 10），并搜索“环境变量”。

3. 点击编辑你账户的环境变量。

   为你的用户账户编辑或创建新的变量 **OLLAMA_HOST**，值为 **0.0.0.0**； 为你的用户账户编辑或创建新的变量 **OLLAMA_ORIGINS**，值为 *****。

4. 点击确定/应用以保存设置。

5. 从 Windows 开始菜单启动 Ollama 应用程序。

#### 在 Linux 上配置

如果 Ollama 作为 systemd 服务运行，应使用 systemctl 设置环境变量：

1. 调用 `systemctl edit ollama.service` 编辑 systemd 服务配置。这将打开一个编辑器。

2. 在 [Service] 部分下为每个环境变量添加一行 Environment：

   ```bash
   [Service]
   Environment="OLLAMA_HOST=0.0.0.0"
   Environment="OLLAMA_ORIGINS=*"
   ```

3. 保存并退出。

4. 重新加载 systemd 并重启 Ollama：

   ```bash
   systemctl daemon-reload
   systemctl restart ollama
   ```

## 总结
通过以上步骤，你已经成功地在本地部署了 DeepSeek 模型，并进行了简单的推理。本地部署 DeepSeek 可以让你更好地控制数据隐私和模型使用，同时也能根据自己的需求进行定制化开发。希望本文的指南能够帮助你顺利完成 DeepSeek 的本地部署，开启属于你自己的大模型之旅。

---

以上就是关于 DeepSeek 本地部署的详细介绍，如果你在部署过程中遇到任何问题，欢迎在评论区留言交流。

**注意**：在部署和使用 DeepSeek 模型时，请遵守相关的开源协议和法律法规。 

## 参考文档

[DeepSeek 本地部署详细教程，小白也能轻松搞定！](https://blog.csdn.net/qq_20890935/article/details/145563763)

[如何将 Chatbox 连接到远程 Ollama 服务：逐步指南 - Chatbox 帮助中心：指南与常见问题](https://chatboxai.app/zh/help-center/connect-chatbox-remote-ollama-service-guide)