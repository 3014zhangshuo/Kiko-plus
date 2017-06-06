---
layout: post
title: ' 方法:给登陆者添加状态信息'
date: 2017-01-03 12:33
comments: true
categories: 
---
####我们需要给user加入一个值来判断他们的身份，比如普通用户和管理员。（这样可以方便解决用户登录后的导向问题）。

>1.采用rails Enums的方法

为users的表单新增栏位`status`
在models/user.rb,设定状态值。`enum status:{ user: 0, admin: 1 }`

>2.改写注册表单

我们需要用这个命令`rails generate devise:views`让隐藏的devise显示出来。
在registrations/new.html.erb里面填入`<%= f.select :status, User.statuses.keys %>`
`User.statuses.keys`会调出你在model填写的所有user的status。

>3.把params[:status]成功put上去

我们发现submit的时候，status这个参数是上传不上去的。原因是rails强大的Strong Parameters不允许我们擅自增加栏位再提交。
![](https://ww2.sinaimg.cn/large/006tKfTcgw1fbdck6lp47j310204wjue.jpg)
怎么办呢，这时候我们就需要模改devise的controller了。
先建立一个RegistrationsController让它继承Devise::RegistrationsController
`class Users::RegistrationsController < Devise::RegistrationsController`
改写里面的Strong Parameters
```
 before_filter :configure_permitted_parameters
 
 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:status])
 end
```
改成routes.rb让它调用新建的RegistrationsController
`devise_for :users, :controllers => { :registrations => "registrations" }`
这样submit后，params[:status]就成功put上去了。
![](https://ww2.sinaimg.cn/large/006tKfTcgw1fbdcrvdnz2j310005ugpd.jpg)

>对于不同的用户注册或登录之后的跳转不同的页面

application_controller.rb
```
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
registrations_controller.rb放在protected下面
```
 def after_sign_up_path_for(resource)
     if params[:status] = "admin"
       company_works_path
     elsif params[:status] = "user"
      root_path
     end
   end
```

参考资料:[1](http://www.justinweiss.com/articles/creating-easy-readable-attributes-with-activerecord-enums/)、[2](https://github.com/plataformatec/devise)、[3](http://stackoverflow.com/questions/17384289/unpermitted-parameters-adding-new-fields-to-devise-in-rails-4-0)、[模改devise](https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out)