# webdav client

一个用shell编写的webdav客户端程序

## 用法：
```
bash wdcli.sh help

    Webdav Client
    Version 1.0.1
    help:
        push <file> <dest>     上传文件
        pull <file>            下载文件
        mkdir <path>           新建文件夹
        mv <file> <dest>       移动文件
        cp <file> <dest>       复制文件
        rm <file>              删除文件
        ls <path>              显示文件列表

        Tips: 除创建目录外，目录结尾均须带 / ,文件列表未作处理，为xml格式。
```