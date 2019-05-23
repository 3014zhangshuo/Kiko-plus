---
layout: post
title: 'Rails: 使用不同的submit commit处理业务逻辑'
date: 2016-12-31
comments: true
tags: [rails]
---

### 表单的写法

```ruby
<% form_for(@object) do |f| %>
    ...
    <%= f.submit '保存' %>
    <%= f.submit '发送' %>
    ...
<% end %>
```

### 渲染出来的HTML

```html
<input type="submit" value="保存" name="commit" />
<input type="submit" value="发送" name="commit" />
```

### 在controller里面就可以这么调用

```ruby
def update
  if params[:commit] == '保存'
    do_save
  elsif params[:commit] == '发送'
    do_send
  end
end
```

### 参考

[how-do-i-create-multiple-submit-buttons-for-the-same-form-in-rails](http://stackoverflow.com/questions/3027149/how-do-i-create-multiple-submit-buttons-for-the-same-form-in-rails)
