---
layout: post
title: 'Ruby: Method source location'
date: 2019-01-24 11:39:22
comments: true
tags: [ruby]
share: false
---

### In console

```ruby
method = User.method(:first)
location = method.source_location # => return array include two values one is file location and other is file line

`atom #{location[0]}:#{location[1]}`
```

### Packaged method put into `.pryrc` or `.irbrc`
```ruby
def source_for(object, method)
  location = object.method(method).source_location
  `atom #{location[0]}:#{location[1]}` if location && location[0] != '(eval)'
  location
end
```

### Reference:
[Ruby 命令行中快速查看函数源码](https://blog.yxwang.me/2013/02/view-ruby-source-in-shell/)
