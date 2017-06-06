---
layout: post
title: '问题:rails入门 routes部分'
date: 2016-10-27 23:10
comments: true
categories: 
---
`Routing Error：uninitialized constant ArticlesController`是没有创建对应的controller，如果建立了可能是名字的错误。
我们调用 Article.find 方法查找想查看的文章，传入的参数 params[:id] 会从请求中获取 :id 参数。我们还把文章对象存储在一个实例变量中（以 @ 开头的变量），只有这样，变量才能在视图中使用。

如果想把 /articles（前面没有 /admin）映射到 Admin::ArticlesController 控制器上，可以这么声明：
```
scope module: 'admin' do
  resources :articles, :comments
end
```
如果想把 /admin/articles 映射到 ArticlesController 控制器（不在 Admin:: 命名空间内），可以这么声明：
scope '/admin' do
  resources :articles, :comments
end
