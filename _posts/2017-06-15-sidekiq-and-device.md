---
layout: post
title: 'Sidekiq Monit'
date: 2017-06-15 16:19
comments: true
tags: [ROR,sidekiql,devise]
comments: true
share: true
---

#### 起因：
   预防大量用户注册时卡顿，Devise发送账号确认信这个动作必须异步完成。用devise还是比较繁重的，有坑还是需要记录一下。
#### 1.安装gem & 引用模块。
   原版gem已经不支持devise4以上的版本了，这里要更改github地址并修改抓取的branch。<br />
   `gem "devise-async", :git => "git@github.com:swapnilchincholkar/devise-async.git", :branch => "devise-4.x"` <br />
   bundle后,修改`user.rb`
   ```
   class User < ActiveRecord::Base
    devise :database_authenticatable, :confirmable, :async # etc ...
   end
   ```
#### 2.让DeviseAsync使用Sidekiq。
添加文件并设定: <br />
```
# config/initializers/devise_async.rb
Devise::Async.enabled = true
Devise::Async.backend = :sidekiq
Devise::Async.queue = :default
```
#### 3.添加覆盖devise原生发信方式的类。
```
# lib/devise_backgrounder.rb

# Mailer proxy to send devise emails in the background
class DeviseBackgrounder

  def self.confirmation_instructions(record, opts = {})
    new(:confirmation_instructions, record, opts)
  end

  def self.reset_password_instructions(record, opts = {})
    new(:reset_password_instructions, record, opts)
  end

  def self.unlock_instructions(record, opts = {})
    new(:unlock_instructions, record, opts)
  end
  
  def initialize(method, record, opts = {})
    @method, @record, @opts = method, record, opts
  end
  
  def deliver
    # You need to hardcode the class of the Devise mailer that you
    # actually want to use. The default is Devise::Mailer.
    Devise::Mailer.delay.send(@method, @record, @opts)
  end

end
```
这里原教程的最后一个方法名称为`deliver_later`，这样会导致发信失败`抛出NoMethod Name "deliver"`,这里要修改方法名为`deliver`。
#### 4.修改部分设定。
* 修改devise邮件默认类。<br />
```
# config/initializers/devise.rb
Devise.setup do |config|
  # ...stuff here
  config.mailer = "DeviseBackgrounder"
  # ...more stuff here
end
```
* 让系统自动加载自定义类。
```
# config/application.rb
  # ..
  config.autoload_paths += %W(#{config.root}/lib)
  # ..
```
* 添加sidekiq.yml于config
```
:queues:
  - default
  - [mailers, 2]
```
