---
layout: post
title: 'rails定时发件任务'
date: 2017-03-04 01:39
comments: true
categories: 
---
定时任务的gem是[whenever](https://github.com/javan/whenever)
[教程来源](https://www.sitepoint.com/schedule-cron-jobs-whenever-gem/)
设置你的发件动作
# file: app/mailers/user_mailer.rb
```
class UserMailer < ActionMailer::Base
  def digest_email_update(options)
    # ... email sending logic goes here
  end
end
```
创建你的rake任务
# file: lib/tasks/email_tasks.rake
```
desc 'send digest email'
task send_digest_email: :environment do
  # ... set options if any
  UserMailer.digest_email_update(options).deliver!
end
```
执行`rake send_digest_email`发送邮件。
安装gem whenever

# file: Gemfile

gem 'whenever', require: false

输入wheneverize指令创建 schedule.rb file
# file: config/schedule.rb
```
every :day, at: '10pm' do
  # specify the task name as a string
  rake 'send_digest_email'
end
```
输入whenever
   whenever -w将记录写入
<hr>
讲whenever套上capistrano
In your "Capfile" file:
`require 'whenever/capistrano'`