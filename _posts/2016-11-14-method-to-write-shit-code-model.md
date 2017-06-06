---
layout: post
title: '将shit一样的code写入model的方法'
date: 2016-11-14 22:29
comments: true
categories: 
---
 ```
 def index
    @posts = Post.where('id NOT IN (SELECT DISTINCT poster_id FROM orders)
                     AND id NOT IN (SELECT DISTINCT asker_id FROM orders)')
  end
 ```
 在controller里面这样写可以排除已经配对的post，但是这样太丑了，最初的尝试是写出scope，发现根本写不出来。
 这才想起老师之前好像是说要定义一个action于是这样写
 ```
 def not_match! 
   self = self.where('id NOT IN (SELECT DISTINCT poster_id FROM orders)
                     AND id NOT IN (SELECT DISTINCT asker_id FROM orders)')
 end
 ```
 妈的这样越看越不合理，果然也报错了。Google得出答案
 ```
 scope :published, -> { where(published: true) }
 def self.published
    where(published: true)
 end
 ```
 这两种写法是等价的，所以最后写成了这样，大功告成。
 ```
 def self.not_match!
   where('id NOT IN (SELECT DISTINCT poster_id FROM orders)
      AND id NOT IN (SELECT DISTINCT asker_id FROM orders)')
 end
 ```
 要排除自己这个配对选项要这么写
 `scope :all_except, -> (post) {where.not(id: post)}`
 前端这样写`Post.all_except.not_match!.map(&:id)`
 但是发现报错了`wrong number of arguments (given 0, expected 1)`
 原因是没有加入参数`Post.all_except（post）.not_match!.map(&:id)`
 这样代码就干净多了，原先是这样的：
 `<%= f.input :asker_id, :as => :select, :collection => Post.where('id NOT IN (SELECT DISTINCT poster_id FROM orders) AND id NOT IN (SELECT DISTINCT asker_id FROM orders)').map(&:id).where.not(:id => post.id)%>`
 现在这样
 `<%= f.input :asker_id, :as => :select, :collection => Post.all_except(post).not_match!.map(&:id)%>`
 