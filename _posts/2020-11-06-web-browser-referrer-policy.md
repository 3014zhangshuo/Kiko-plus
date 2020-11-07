---
layout: post
title: "Referrer Policy 是如何影响 referrer 值的"
date: 2020-11-06
tags: [web]
---

**本文只详细描述 `strict-origin-when-cross-origin` policy**

> Tips: Rails 中默认的 Referrer-Policy 是 strict-origin-when-cross-origin

#### 首先，解释一下什么是同源？

同源策略要求三同，即：同域，同协议，同端口。
  - 同域即host相同，顶级域名，一级域名，二级域名，三级域名等必须相同，且域名不能与 ip 对应；
  - 同协议要求，http与https协议必须保持一致；
  - 同端口要求，端口号必须相同。

#### 再解释一下 strict-origin-when-cross-origin policy 的含义

  - origin-when-cross-origin
    - 当发请求给同源网站时，浏览器会在referrer中显示完整的URL信息，发个非同源网站时，则只显示源地址（协议、域名、端口）
  - strict-origin-when-cross-origin
    - 和origin-when-cross-origin相似，只是不允许referrer信息显示在从https网站到http网站的请求中（安全降级）。

#### 详细解释

- same with http but not same origin
  - http://blog.zhangshuo.com/tags -> http://www.zhangshuo.com/hots
    - 因为是非同源，referrer 只显示源地址（协议、域名、端口）所以 referrer 为 http://blog.zhangshuo.com/

- https downgrade to http and not same origin
  - https://blog.zhangshuo.com/tags -> http://www.zhangshuo.com/hots
    - Referrer 为 <空>，因为上诉的策略，https -> http 是 downgrade 不显示 referrer

---

* https://segmentfault.com/a/1190000017579464
* https://juejin.im/post/6844903842484600846
* https://edgeguides.rubyonrails.org/security.html
