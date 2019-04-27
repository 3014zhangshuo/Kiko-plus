---
layout: post
title: "Nginx 无法正常重启"
date: 2019-04-19 21:39:22
comments: true
tags: [nginx]
share: false
---

# 正常情况可以使用下面命令进行重启，调用/etc/init.d/nginx脚本
```shell
$ sudo service nginx restart
```
# 也可以先停止nginx，再启动
```shell
$ sudo nginx -s stop
$ sudo nginx
```
# 出现命令无法重启的情况，kill掉nginx主进程再启动
# 注意不能用kill -9杀掉进程，nginx启动时有子进程
```shell
$ ps -ef | grep nginx
$ kill -QUIT nginx_master_pid
$ sudo nginx
```
