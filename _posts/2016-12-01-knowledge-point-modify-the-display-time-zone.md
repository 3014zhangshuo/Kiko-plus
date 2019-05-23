---
layout: post
title: 'Rails：修改显示北京时区'
date: 2016-12-01
comments: true
tags: [rails]
---
在`config/environments`加入下面两行就可以了
```ruby
config.active_record.default_timezone = :local
config.time_zone = "Beijing"
```
