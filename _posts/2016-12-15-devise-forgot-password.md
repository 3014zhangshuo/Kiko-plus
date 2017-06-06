---
layout: post
title: '方法：devise忘记密码'
date: 2016-12-15 12:22
comments: true
categories: 
---
####devise原本的忘记密码不加入一些东西是不能work的，方法如下：

#####修改config/environments/development.rb
```
  config.action_mailer.smtp_settings = {
    :port           => 587,
    :address        => "smtp.gmail.com",
    :user_name      => "you@gmail.com",
    :password       => "*******",
    :domain         => 'localhost:3000', #eg: 'yourappname.herokuapp.com'
    :authentication => :plain,
    :enable_starttls_auto => true
  }
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false
```

#####修改devise.rb
#####添加`config.mailer_sender = '3014zhangshuo@gmail.com' `

#####在config/environment.rb加入下面一行。
`Rails.application.routes.default_url_options[:host] = 'localhost'`