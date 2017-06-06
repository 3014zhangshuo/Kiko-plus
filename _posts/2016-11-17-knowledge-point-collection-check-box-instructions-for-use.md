---
layout: post
title: '知识点：collection_check_box的使用说明'
date: 2016-11-17 09:30
comments: true
categories: 
---
语法
```
= form_for @post do |form|
  = form.collection_check_boxes :author_ids, Author.all, :id, :name_with_initial
```
创建的form表单是这样的
（If you have authors with the IDs 1, 2 and 3, the check boxes above will be named like this:）
```
<input type="checkbox" name="post[author_ids][]" value="1">
<input type="checkbox" name="post[author_ids][]" value="2">
<input type="checkbox" name="post[author_ids][]" value="3">
<input type="hidden" name="post[author_ids][]" value="">
```
末尾有这个hidden输入，用户可以取消自己所选的复选框。如果这条hidden不存在，会丢失所有的params，list的值也不会上传到model。
在controller里面创建的表单是这样的`{ 'post' => { 'author_ids' => ['1', '2', '3', ''] } }`
我们上传ids这个值，需要在strong_params加入相应的栏目
这样加是不会work的：params[:post].permit(:subject, :body, :author_ids)
server log显示：Unpermitted parameters: author_ids
需要在后面加一个空的数组：params[:post].permit(:subject, :body, :author_ids => [])


参考网站：
https://makandracards.com/makandra/32147-rails-4-introduced-collection_check_boxes
http://apidock.com/rails/v4.0.2/ActionView/Helpers/FormOptionsHelper/collection_check_boxes
http://apidock.com/rails/v4.2.1/ActiveRecord/Calculations/ids