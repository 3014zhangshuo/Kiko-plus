---
layout: post
title: "Github push Timeout"
date: 2019-06-17
tags: [Bug]
---

Github的网站可以访问，但是ping不通，也push不了。怀疑ping获取的ip地址不对，使用`http://github.com.ipaddress.com/`查询到Github的IP，`sudo vim /etc/hosts`添加`192.30.253.112 github.com`


