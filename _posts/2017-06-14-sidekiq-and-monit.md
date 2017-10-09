---
layout: post
title: 'Sidekiq Monit'
date: 2017-06-14 16:19
comments: true
tags: [ROR,sidekiq]
comments: true
share: true
---
#### 起因：
   由于近期网站用户数量可能会激增。注册的验证邮件，订单的确认邮件都有可能让用户端卡主。就需要用异步任务来完成这些发件动作。

#### 添加必备的gem

```
gem "sidekiq"
gem 'sidekiq-statistic'   #sidekiq查看任务完成情况
gem "capistrano-sidekiq", group: :development
```

#### 完成sidekiq后端页面设定
* 在initializes/sidekiq.rb加入`require 'sidekiq/web'`和 `require 'sidekiq-statistic'`
* 添加路由设定<br />
  ```
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  ```
#### 准备异步任务
* 修改rails异步任务设定, 在env/pro `config.active_job.queue_adapter = :sidekiq`
* 创建任务方法（这里要说的是，方法参数建议传id。原因很简单。）

#### Capistrano设定sidekiq
在capfile加入，sidekiq的顺序在bundler和passenger的下面，要不然会报错。
```
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/passenger"
require "capistrano/sidekiq"
``` 
在deploy.rb加入
```
set :pty, false
set :passenger_restart_with_touch, true
```
#### ubuntu安装redis
* `sudo apt-get install redis-server`

#### 安装monit检测sidekiq任务状态，挂掉自动重启
* `sudo apt-get install monit` 安装monit
* `sudo vi /etc/monit/monitrc` <br />
   打开四行注释<br />
   ```
    set httpd port 2812 and
     use address localhost 
     allow localhost        
     allow admin:monit
    ```
* 创建sidekiq.conf设定文件 `sudo vim /etc/monit/conf.d/sidekiq.conf`加入如下代码<br />
  ```
   check process sidekiq_yourprojectname_production0
   with pidfile "/home/apps/yourprojectname/shared/tmp/pids/sidekiq-0.pid"
   start program = "/bin/su - deploy -c 'cd /home/apps/yourprojectname/current && /usr/bin/env bundle exec sidekiq   --index 0 --pidfile /home/apps/yourprojectname/shared/tmp/pids/sidekiq-0.pid --environment production  --logfile /home/apps/yourprojectname/shared/log/sidekiq.log  -d'" with timeout 30 seconds

   stop program = "/bin/su - deploy -c 'cd /home/apps/yourprojectname/current && /usr/bin/env bundle exec sidekiqctl stop /home/apps/yourprojectname/shared/tmp/pids/sidekiq-0.pid'" with timeout 20 seconds
   group yourprojectname-sidekiq
  ```






