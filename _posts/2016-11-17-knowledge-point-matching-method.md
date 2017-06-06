---
layout: post
title: '知识点：配对方法'
date: 2016-11-17 14:50
comments: true
categories: 
---
```     
<% @posts.each do |post| %>
   <tr>
     <td> <%= post.id %> </td>
     <td><%= post.title %></td>
     <td><%= post.description %></td>
     <td><%= post.eat_venue %></td>
     <td><%= post.eat_day %></td>
     <td>
     <%= simple_form_for Order.new , :url => admin_orders_path(:poster_id => post.id ) do |f| %>
       <div class="center">
        <%= f.input :asker_id, :as => :select, :collection => Post.no_match.all_except(post.id).            map(&:id), :label => "配对者", class: "pagination-centered" %>
         <%= f.submit '配对' ,:class => "btn btn-default center-block" %>
       </div>
      <% end %>
      </td>
    </tr>
<% end %>
```
这是一个post的配对功能，如果有人发出了一个邀约，我们可以在后台给他在指定一个进行配对。思路是在post的表单显示页面加上一个order的新建表单。order表单需要两个数据才能够形成。原本上面写的是poster_id可以去post.id。但是poster_id应该改为post_id，因为poster_id代表user、post_id才代表post，order里面需要post的数据和被配对人的数据才比较合理。（这样的命名给制作功能造成很大的困扰。下次命名一定要谨慎）。下面的选择框就是重点了，map就是把所有的Post.id拿出来，让你选择。

map知识点参考：http://stackoverflow.com/questions/12084507/what-does-the-map-method-do-in-ruby