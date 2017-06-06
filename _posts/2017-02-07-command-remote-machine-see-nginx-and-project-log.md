---
layout: post
title: '命令:远端机器查看nginx和专案的log'
date: 2017-02-07 20:27
comments: true
categories: 
---
>在远端如何呢进入 rails console?

`bin/rails c production` 或 `bundle exec rails c production`

>Nginx log

nginx的log位置在 `/var/log/nginx/` 或 `/opt/nginx/logs` 下，ResumeHack在`/opt/nginx/logs`
在home目录下输入`vi /opt/nginx/logs/error.log`

>production log

cd ~/your_project/current
tail -n 500 log/production.log 这样会显示最后的500行
或是 tail -f log/production.log 這这样会挂着一直显示

<hr>
[source](https://ihower.tw/rails/deployment.html#sec5)