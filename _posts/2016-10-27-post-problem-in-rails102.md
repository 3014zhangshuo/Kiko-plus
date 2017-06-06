---
layout: post
title: '问题:rails102中的post的问题'
date: 2016-10-27 19:11
comments: true
categories: 
---
准备在group显示post的内容
```
<p><%= @group.description %></p>
  <% @posts.each do |post| %>
    <%= post.content %>
   <%= post.user.email %>
   <%= post.created_at %>
       <% end %>
```
但是报错了 `no method each`检查post controller没有问题。
因为是在group的页面显示post的内容，必须在group的show里面加
下相关参数
```
def show
  @group = Group.find(params[:id])
  @posts = @group.posts
end
```
记住这里的写法

```
def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
 ```
