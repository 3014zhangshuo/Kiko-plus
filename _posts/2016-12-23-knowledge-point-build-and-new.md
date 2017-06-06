---
layout: post
title: '知识点:build and new , create ,  ! , save'
date: 2016-12-23 11:27
comments: true
categories: 
---
 >create , ! , save
 
 save：rails中的save其实是create_or_update，新建或修改记录！不一定是新建，
 create: create = new + 执行sql。
 !：new!, create!, build!与new, create, build的区别是带!的方法会执行validate，如果验证失败会抛出导常。
 
 >build和new的区别
 
 new ：只是在内存中新建一个对象，操作数据库要调用save方法。
 build：与new基本相同，多用于一对多情况下。
```
 @article = Article.create(params[:article])  (o)
 @article = Article.build(params[:article])   (x)
```
 IN RUBY
```
 Order.new(o)
 Order.build(x)
```
 IN RAILS
```
 Order.new(o)
 Order.build(x)
 current_user.orders.new(o)
 current_user.orders.build(o)
 [@rder = Order.new + @order.user = current_user] = [@order = current_user.orders.build]
```
 
```
o = Object.new(:foo => 'bar')
o.save

等价于

o = Object.create(:foo => 'bar')
```
 资料[1](http://rubyer.me/blog/262/)