> 特别说明：源码、JDK、数据库、Redis等安装或存放路径禁止包含中文、空格、特殊字符等

采用`kkFileView`文件文档在线预览解决方案，使用主流的`Spring Boot`搭建，易上手和部署，基本支持主流办公文档的在线预览，如doc,docx,xls,xlsx,ppt,pptx,pdf,txt,zip,rar,图片,视频,音频等等

## 一 环境要求

### 1.1 开发环境

| 类目    | 版本或建议  |
|-------|---------|
| 硬件    | 开发电脑建议使用I3及以上CPU，16G及以上内存  |
| 操作系统  | Windows 10/11，MacOS   |
| JDK   | 默认使用JDK 21，如需要切换JDK 8/11/17版本请参考文档调整代码，推荐使用 `OpenJDK`，如 `Liberica JDK`、`Eclipse Temurin`、`Alibaba Dragonwell`、`BiSheng`等发行版； |
| Maven | 依赖管理工具，推荐使用 `3.6.3` 及以上版本  |
| IDE   | 代码集成开发环境，推荐使用 `IDEA2024` 及以上版本，兼容 `Eclipse`、 `Spring Tool Suite` 等IDE工具 |

### 1.2 运行环境

> 适用于测试或生产环境

| 类目 | 版本说明或建议    |
| --- |--------------|
| 服务器配置 | 建议至少在 `4C/16G/50G`  的机器配置下运行；  |
| 操作系统 | 建议使用 `Windows Server 2019` 及以上版本或主流 `Linux` 发行版本，推荐使用 `Linux` 环境；兼容 `统信UOS`，`OpenEuler`，`麒麟服务器版` 等信创环境；    |
| JRE | 默认使用JRE 21，如需要切换JRE 8/11/17版本请参考文档调整代码；推荐使用 `OpenJDK`，如 `Liberica JDK`、`Eclipse Temurin`、`Alibaba Dragonwell`、`BiSheng`等发行版；   |
| Redis | 数据缓存，推荐使用 `5.0` 及以上版本 |

## 二 Maven私服配置

> Apache Maven 3.6.3及以上版本<br>解决以下依赖无法从公共Maven仓库下载的问题

打开Maven安装目录中的 `conf/settings.xml` 文件，<br>
在 `<servers></servers>` 中添加如下内容

```xml
<server>
  <id>maven-releases</id>
  <username>您的账号</username>
  <password>您的密码</password>
</server>
```

在 `<mirrors></mirrors>` 中添加

```xml
<mirror>
  <id>maven-releases</id>
  <mirrorOf>*</mirrorOf>
  <name>maven-releases</name>
  <url>https://repository.jnpfsoft.com/repository/maven-public/</url>
</mirror>
```

## 三 关联项目

> 需要使用下表中的对应分支

| 项目                     | 分支    | 说明                   |
| ------------------------ | ------------- | ---------------------- |
| **后端**(任一后端服务)   |                 |                        |
| jnpf-java-boot           | v6.1.x-stable  | Java单体后端项目源码      |
| jnpf-java-cloud          | v6.1.x-stable  | Java微服务后端项目源码    |
| jnpf-dotnet              | v6.1.x-stable  | .NET单体后端项目源码      |
| jnpf-dotnet-cloud        | v6.1.x-stable  | .NET微服务后端项目源码    |

## 四 部署指南

### 4.1 环境要求

`LiberOffice` (Windows下已内置，CentOS或Ubuntu下会自动下载安装，MacOS下需要自行安装)

### 4.2 部署运行

#### 4.2.1 开发环境

- a.IDEA导入项目
- b.调整配置，打开 `server/src/main/config/application.properties`
  - 运行端口：30090（默认），位于配置文件第 1 行
  - Redis配置，位于配置文件第 45-49 行
  - 预览服务地址，本地开发环境需要把地址修改为 `http://localhost:30090`
- c.启动项目，`server/src/main/java/cn/keking/ServerMain`
- d.打开`http://localhost:30090`测试页面

#### 4.2.2 测试生产环境

- a.打包，打开 `/server/target` 主要有以下几个文件
  - kkFileView-xxx.jar(一般用于更新)
  - kkFileView-xxx.zip(windows环境下首次部署)
  - kkFileView-xxx.tar.gz(Linux环境下首次部署)
- b.上传至服务器
  - 解压上传的文件
  - 调整配置，打开 `config/application.properties`，配置参考上述开发环境内容
  - 进入 `bin` 目录，运行startup脚本(首次部署，之后更新及维护都在bin目录下)
- c.Nginx配置说明

  例如访问地址为 `https://java.jnpfsoft.com` ,文件预览部署在内网 `192.168.0.18` 服务器上，需要在 `Nginx` 中添加反向代理如下

  ```text
    # 文件预览服务
    location /FileServer {
      proxy_pass 192.168.0.18:30090;
    }

    # 解决文件预览服务无法加载js,css问题
    location ~ /FileServer/*.*\.(js|css)?$ {
	  proxy_pass 192.168.0.18:30090;
    }

  ```

  修改文件预览配置文件如下两项,打开服务器上的 `kkFileView-xxx/configapplication.properties`

  ```text
    server.servlet.context-path= ${KK_CONTEXT_PATH:/FileServer}
    base.url =https://java.jnpfsoft.com/FileServer
  ```

## 五 使用指南

1、单文件预览

```aidl
// 要预览文件的访问地址
let previewUrl = 'http://127.0.0.1:8080/file/test.txt'

// 使用
http://127.0.0.1:30090/onlinePreview?url='+encodeURIComponent(Base64.encode(previewUrl))

```
2、http/https下载流url预览

```aidl
// 要预览文件的访问地址
let previewUrl = 'http://127.0.0.1:8080/filedownload?fileId=1'

// 使用
http://127.0.0.1:30090/onlinePreview?url='+encodeURIComponent(Base64.encode(previewUrl))

```

3、更多参考官方文档（`https://kkfileview.keking.cn/zh-cn/docs/usage.html`）

## 六 常见问题

1、预览乱码(字体问题)

大部分Linux系统上并没有预装中文字体或字体不全，需要把常用字体拷贝到Linux服务器上，具体操作如下： 下载如下字体包 `http://kkfileview.keking.cn/fonts.zip` 文件解压完整拷贝到Linux下的 `/usr/share/fonts` 目录。然后依次执行`mkfontscale`、`mkfontdir`、`fc-cache`使字体生效

> 特别说明：安装字体前确保Linux服务器已安装 mkfontscale、fontconfig，如未安装运行以下命令

CentOS运行如下命令

  ```bash
  yum install mkfontscale fontconfig -y
  ```

Ubuntu运行如下命令

  ```bash
  sudo apt-get install ttf-mscorefonts-installer fontconfig -y
  ```

2、更多问题请参考官方文档说明(`https://kkfileview.keking.cn/zh-cn/docs/faq.html`)
