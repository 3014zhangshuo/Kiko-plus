---
layout: post
title: "Ruby: 卸载 mixin 的 Module"
date: 2020-05-26
tags: [ruby]
---

```ruby
module Mod
  def foo
    puts "fooing"
  end
end

class C
  include Mod

  def self.remove_module(m)
    m.instance_methods.each { |m| undef_method(m) }
  end
end

c = C.new
c.foo # => fooing
C.remove_module(Mod) # => ["foo"]
c.foo # => NoMethodError
```

*主要是调用 `undef_method`*


