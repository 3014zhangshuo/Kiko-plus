---
layout: post
title: "读书笔记：Ruby Time 格式转换"
date: 2020-09-19
tags: [ruby, 读书笔记, 时间格式]
---

#### ISO 8601 国际标准时间格式

```ruby
require "time"

t = Time.now
p t.iso8601 # => "2020-09-19T11:57:41+08:00"
```

#### rfc2822 符合电子邮件头部信息的Date，RFC (Request For Comments)

```ruby
require "time"

t = Time.now
p t.rfc2822 # => "Sat, 19 Sep 2020 11:59:15 +0800"
```
