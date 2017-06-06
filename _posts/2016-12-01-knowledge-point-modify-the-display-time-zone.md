---
layout: post
title: '方法：修改显示时区'
date: 2016-12-01 15:42
comments: true
categories: 
---
  #####很简单，在config/environments加入下面两行就可以了
  ```
  config.active_record.default_timezone = :local
  config.time_zone = 'Beijing'
  ```