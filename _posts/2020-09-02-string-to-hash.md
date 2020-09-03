---
layout: post
title: "Ruby-习题: str2hash"
date: 2020-09-02
tags: [ruby]
---

定义方法 str2hash，将被空格、制表符、换行符隔开的字符串转化为散列。

```ruby
str = "blue 蓝色\rwhite 白色\nred 红色"

def str2hash(str)
  hash = Hash.new
  words = str.split(' ') # str.split(/\s+/)

  while key = words.shift
    value = words.shift
    hash[key] = value
  end

  return hash
end
```
