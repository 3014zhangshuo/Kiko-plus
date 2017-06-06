---
layout: post
title: '方法:test清除数据库的方法'
date: 2016-12-17 22:52
comments: true
categories: 
---
安装gemfile
```
group :test do
  gem "database_rewinder"
end
```
创建一个文件`touch spec/support/database_rewinder.rb`
```
RSpec.configure do |config|
  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end
end
```