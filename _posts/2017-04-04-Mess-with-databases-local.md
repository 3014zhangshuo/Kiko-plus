---
layout: post
title: '将远端数据restore本地数据库后，无法migrate问题'
date: 2017-05-29 18:08
comments: true
tags: [Postgres,记录,bug]
comments: true
share: true
---
#### 问题描述
把production和developmen都使用pg后，拿生产环境的数据进行测试更方便了，但是因为本地的多加了一些表。
restore本地数据后，需要migrate重新进行迁移，但是总是报错环境问题，输入</ br>
`$ RAILS_ENV=development rake db:migrate`报错也没有改变。
#### 报错如下
```
rails aborted!
ActiveRecord::ProtectedEnvironmentError: You are attempting to run a destructive
action against your 'production' database.
If you are sure you want to continue, run the same command with the environment
variable:
DISABLE_DATABASE_ENVIRONMENT_CHECK=1
```
#### Google结果
google了一下，还真有人跟我是一样的问题，下面是他的解释
```
This is a protection so that you don’t delete any production data by accident.
But what happened to me was that I somewhen reconfigured my local system
to be productive (probably to test something with real data).
It is possible to reconfigure the database environment in
ar_internal_metadata with the following command:
`bin/rails db:environment:set RAILS_ENV=development`
With that database rake tasks to not complain anymore if you mess with
databases locally.
```
[解答](https://blog.schmijos.ch/2016/11/22/active-record-database-env-check/)





