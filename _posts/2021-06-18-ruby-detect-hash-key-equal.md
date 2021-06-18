---
layout: post
title: "Ruby 是如何判断 hash 中的 key 是同一个"
date: 2021-06-18
tags: [ruby]
---

对于两个键 key1、key2, 当 key1.hash 与 key2.hash 得到的整数值相同，且 key1.eql?(key2) 为 true 时，就会认为这两个键是一致的。

```ruby
class User
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hash
    @name.hash
  end

  def ==(o)
    o.name == self.name
  end
  alias_method :eql?, :==
end

u1 = User.new("Joe")
u2 = User.new("Joe")

m = { u1 => 1 }

m.merge!(u2 => 2)

p m # => {#<User:0x00007fe10b18d640 @name="Joe">=>2}
```
