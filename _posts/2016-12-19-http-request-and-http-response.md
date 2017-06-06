---
layout: post
title: 'HTTP Request和 HTTP Response'
date: 2016-12-19 16:15
comments: true
categories: 
---
>HTTP(Hyper Text Transfer Protocol)[超文本传输协议]

>什么是HTTP Request与HTTP Response？

  我们点击网页的时候就是就是从客户端(client)向服务器端(server)发出一个消息的请求(request)，然后服务器端就会把消息回传(response)给客户端.
  ```
  这里需要注意一下：比如我们自己建立了一个网站，需要与第三方的网站服务器如微信服务器进行交互，如果是我们自己的网站向微信服务器发送Request，微信服务器返回Response信息，那么我们的网站就是客户端，而微信服务器是服务端；如果是微信服务器向我们的网站发送Resquest，而我们的服务器回复Response服务器，那么我们的网站就是服务器端，而微信服务器就是客户端。总之，就是两个进程之间的通信而已。
  ```
>无状态协议

但是客户端和服务器端还有一个问题就是HTTP是无状态协议(stateless protocol),也就是说每次客户端向服务器端request，服务器端都会认为是一个新的request，无法记录客户端的信息。这样就会导致很多麻烦，比如说需要登入才能进入的页面，你每一次点击都会再要求你登录一次。

>解决办法Session

服务器端对于访问的客户端,会生成该客户端的唯一信息，存储Session中，Session位于服务器，可以保持在服务器的内存中，也可以保持在文件系统中，也可以保存在服务器的数据库中。
但是有了Session还是不够的，因为每次访问的客户端都是一次新的request,因此需要在request的信息中包含有客户端的信息，才能够与服务器端的Session进行对比，来确定是不是同一个客户端。所以需要Session Tracking，来识别客户端。
Session Tracking的三种方法:
1.Cookies
  存储在客户端，每一个cookie对应唯一的SessionID，当客户端发送request的时候，该信息会一块发过去，然后服务器端就能根据Cookie的信息与Session的信息比对，来判断客户端的Request是否第一次请求；
  Cookie中会包含过期时间信息，如果Cookie过期，那么服务器端也会认为是第一次Request，进而需要用户登录；
  禁止Cookie后，有些网站就无法登录了;
2、URL Rewirting
   对于客户端禁用Cookie的情况，如果还想能够识别Request，那么就可以使用URL Rewriting的方法，在URL中会包含一段信息，这段信息能够与相应的Session唯一对应，这样当URL传到服务器端后就能够判断特定的Session了。通过URL Rewriting，无需在客户端保存有Cookies信息，与特定Session相关联的信息直接通过URL来回传输。
　　对于采用URL Rewriting方法的，如果我们保存一个网址为标签后，那么以后再打开标签的话，会提示Session过期,因为Session有一定的时间期限，过期后，服务器端就会删除相应的Session信息，以节省资源。
3.使用Hidden类型的Form标签
通过 hidden类型的form标签，例如`<input type="hidden".../>`，这种方式有两个缺点：一是我们可以通过HTML源代码就能够看到一些信息，甚至是一些敏感信息；二是为了区分不同的用户，该方法只能够用在动态网页中，对于纯HTML的，就没有办法了。
  

感谢吴光磊的博客(地址)[http://www.cnblogs.com/wuguanglei/p/4293350.html]
