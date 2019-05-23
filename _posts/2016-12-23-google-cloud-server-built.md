---
layout: post
title: '使用Google Cloud搭建shadowsocks'
date: 2016-12-23
comments: true
tags: [教程]
---
```shell
sudo passwd root mypassword # 设置root用户密码

su # 管理员登录

apt-get install python-pip # 安装python-pip

pip install shadowsocks # 安装shadowsocks

sudo ssserver -p 443 -k password -m aes-256-cfb --user nobody -d start # 开启shadowsocks

dns-server=119.29.29.29, 223.5.5.5, 114.114.114.114 # 设置DNS
```

### 参考：

[github-shadowsocks](https://github.com/shadowsocks/shadowsocks/tree/master)
