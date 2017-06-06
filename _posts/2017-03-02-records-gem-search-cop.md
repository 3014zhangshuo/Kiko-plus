---
layout: post
title: '记录:gem search_cop'
date: 2017-03-02 10:07
comments: true
categories: 
---
`gem 'search_cop'`是一个可以根据activerecord的关联关系进行搜索的gem
```
class Book < ActiveRecord::Base
  include SearchCop

  search_scope :search do
    attributes :title, :description, :stock, :price, :created_at, :available
    attributes :comment => ["comments.title", "comments.message"]
    attributes :author => "author.name"
    # ...
  end

  has_many :comments
  belongs_to :author
end
```
redmine下面还有all的方法，但是如果本身的attribute用了all的话，关联的attribute要引用就不行了
用order("id DESC")对搜索结果进行排序的话，会报错