---
layout: post
title: '方法:how to create multiple submit buttons for the same form'
date: 2016-12-31 13:19
comments: true
categories: 
---
表单的写法
```
<% form_for(something) do |f| %>
    ..
    <%= f.submit 'A' %>
    <%= f.submit 'B' %>
    ..
<% end %>
```
在web的显示
```
<input type="submit" value="A" id=".." name="commit" />
<input type="submit" value="B" id=".." name="commit" />
```
在controller里面就可以这么改
```
def <controller action>
    if params[:commit] == 'A'
        # A was pressed 
    elsif params[:commit] == 'B'
        # B was pressed
    end
end
```

[1](http://stackoverflow.com/questions/3027149/how-do-i-create-multiple-submit-buttons-for-the-same-form-in-rails)
[]()