---
layout: post
title: "Ruby 时区转化"
date: 2020-09-19
tags: [ruby]
---

#### 使用 ActiveSupport 库

```ruby
require 'active_support/core_ext/time'

t = Time.now
p t # => 2020-09-19 12:02:24.29833 +0800

p t.in_time_zone('Pacific Time (US & Canada)') # => Fri, 18 Sep 2020 21:02:24 PDT -07:00
```

#### Pure Ruby Way

```ruby
Time.now.utc.localtime("-07:00")
```
