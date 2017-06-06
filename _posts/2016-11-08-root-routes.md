---
layout: post
title: '问题:root routes '
date: 2016-11-08 12:52
comments: true
categories: 
---
`root :to => "pages#show", :id => '1'`
引用非index的页面
```
<%= form_for @post do |f| %>
<%= render :partial => "form", :locals => {:f=>f} %>
<% end %>
```
不加local => {：f=>f}不可以，因为要循环f

参考文档：[1](http://apidock.com/rails/ActionView/PartialRenderer)