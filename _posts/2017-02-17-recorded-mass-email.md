---
layout: post
title: '记录:群发邮件'
date: 2017-02-17 19:32
comments: true
categories: 
---
前端传送ids这个参数
```
<%= form_tag  send_email_users_admin_users_path, method: :post do %>
<% @users.each do |user| %>
 <div class="col-md-12">
  <%= check_box_tag 'ids[]', user.id  %>
  <%= label_tag :checkbox, user.email %>
  </div>
<% end %>
  <%= submit_tag "submit" %>
<% end %>
```
后端处理
```
    def send_email_users
        if params[:ids].present?
            @users = User.where(id: params[:ids].split(',')) #把string分割成数组
            @users.each do |user|
                UserMailer.notify_user_confirm(user).deliver!
            end
            redirect_to admin_users_path
       end
    end
```

