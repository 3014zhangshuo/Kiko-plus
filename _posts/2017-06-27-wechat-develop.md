---
layout: post
title: 'SSL HTTPS Nginx config'
date: 2017-07-06 16:19
comments: true
tags: [nginx]
comments: true
share: true
---
### 通过[acme.sh](https://github.com/Neilpang/acme.sh)给网站加入SSL证书和证书的自动更新

#### 远端服务器安装acme.sh

* $ `curl https://get.acme.sh | sh`。
* 然后重新加载`.bashrc` , $`source ~/.bashrc `。

#### 使用acme.sh命令下载SSL证书
`acme.sh --issue -d your-domian -w /home/User/your-application/current/public`

#### 将SSL证书复制到另外的目录，并配置Nginx。

```
acme.sh --installcert -d your-domian \
               --keypath       /home/User/ssl/your-domian.key  \
               --fullchainpath /home/User/ssl/your-domian.key.pem \
               --reloadcmd     "sudo service nginx reload"
```
这样文件就会复制到ssl的文件夹里面。

#### 修改sudoer文件，让运维用户`sudo service nginx reload`不需要输入密码

