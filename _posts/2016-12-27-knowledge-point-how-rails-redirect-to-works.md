---
layout: post
title: '知识点:how rails redirect_to works'
date: 2016-12-27 13:17
comments: true
categories: 
---

当Rails程序运行到redirect_to时，需要等待浏览器发送一个新的http请求再继续执行后面的代码。它的原理是通过向客户端发送302的HTTP状态码告诉浏览器需要重定向到指定的URL 。
通过redirect_to方法，服务器发送302HTTP状态码到浏览器并重定向，客户端(用户浏览器)将发送一个新的请求到服务器，indexaction 将被执行。
#####301，302 都是HTTP状态的编码，都代表着某个URL发生了转移，不同之处在于：
#####301 redirect: 
301 代表永久性转移(Permanently Moved)，永久重定向意味这用戶代理应该忘記旧的URL并从现在起使用新的URL，更新其可能已经保存的任何引用（即，书签，或者在Google的情況下，其搜索数据库）。
#####302 redirect: 
302 代表暂时性转移(Temporarily Moved)，临时重定向是一次性的事情。原始URL仍然有效，但对于此特定请求，用戶代理应从重定向URL提取新资源。从网址A做一个302重定向到网址B时，主机服务器的隐含意思是网址A随时有可能改主意，重新显示本身的内容或转向其他的地方。

http1.0：只有302码，没有303和307状态码；
http1.1：有302（理论上是可以放弃的，为了兼容1.0被保留，而且因为目前程序都没那么讲究所以302大量出现在一些项目上），303，307。


[1](https://my.oschina.net/huangwenwei/blog/713516)
[2](http://blog.csdn.net/ghj1976/article/details/1794684)
