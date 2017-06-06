---
layout: post
title: 'Google cloud 服务器搭建'
date: 2016-12-23 12:31
comments: true
categories: 
---
sudo passwd root  /设置管理员密码/

su  /管理员登录/

apt-get install python-pip

pip install shadowsocks

sudo ssserver -p 443 -k password -m aes-256-cfb --user nobody -d start

dns-server=119.29.29.29, 223.5.5.5, 114.114.114.114

https://github.com/shadowsocks/shadowsocks/tree/master