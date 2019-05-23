---
layout: post
title: '方法: 给登陆者添加状态信息'
date: 2017-01-03
comments: true
tags: [rails]
---
我们需要给user加入一个值来判断他们的身份，比如普通用户和管理员。

### 使用rails Enums的方法

为users的表单新增栏位`status`
在models/user.rb,设定状态值。`enum status:{ user: 0, admin: 1 }`

### 改写注册表单

使用这个命令`rails generate devise:views`让隐藏的devise views显示出来。

在`registrations/new.html.erb`里面填加`<%= f.select :status, User.statuses.keys %>`

使用`User.statuses.keys`会调出你在model填写的所有user的status。

### 模改Devise的Strong Paramters，让用户可以成功储存status

我们发现submit的时候，status这个参数是上传不上去的。
![](https://ww2.sinaimg.cn/large/006tKfTcgw1fbdck6lp47j310204wjue.jpg)
那怎么办，这时候我们就需要模改devise的controller了。
先建立一个`User::RegistrationsController`让它继承自`Devise::RegistrationsController`，复写里面的`configure_permitted_parameters`方法。

```ruby
class Users::RegistrationsController < Devise::RegistrationsController

 before_filter :configure_permitted_parameters

 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:status])
 end
end
```

### 更改路由，让Devise使用User::RegistrationsController
```ruby
devise_for :users, :controllers => { :registrations => "user/registrations" }
```

user status成功被储存。
![](https://ww2.sinaimg.cn/large/006tKfTcgw1fbdcrvdnz2j310005ugpd.jpg)

### 对于不同的用户注册或登录之后的跳转不同的页面

在`ApplicationController`里面添加方法：

```ruby
def after_sign_in_path_for(resource)
  if current_user && current_user.status == "admin"
    company_works_path
  elsif current_user && current_user.status == "user"
    root_path
  else
    root_path
  end
end
```

在`User::RegistrationsController`里面添加方法：

```ruby
...

protected

...

def after_sign_up_path_for(resource)
  if params[:status] = "admin"
    company_works_path
  elsif params[:status] = "user"
    root_path
  end
end
```

### 参考

* [creating-easy-readable-attributes-with-activerecord-enums](http://www.justinweiss.com/articles/creating-easy-readable-attributes-with-activerecord-enums/)
* [github-devise](https://github.com/plataformatec/devise)
* [unpermitted-parameters-adding-new-fields-to-devise-in-rails-4-0](http://stackoverflow.com/questions/17384289/unpermitted-parameters-adding-new-fields-to-devise-in-rails-4-0)
* [How-To-Redirect-to-a-specific-page-on-successful-sign-in](https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out)
