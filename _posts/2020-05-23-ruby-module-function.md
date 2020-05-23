---
layout: post
title: "Ruby module_function"
date: 2020-05-23
tags: [ruby]
---

`module_function` 的作用域类似 `private`，它作用于所处位置以下的方法，或者是把方法名作为参数一样传递过去，主要有两种功效：

1. 做为 Module 的 ClassMethod：

```ruby
module A
  module_function

  def hi
    puts "hi from module A"
  end
end

A.hi
```

2. 可以作为私有方法 mixin 到其他模块

```ruby
module B
  module_function

  def hi
    puts "hi from module B"
  end
end

class C
  include B

  def hello
    hi
  end
end

C.new.hi # => NoMethodError private method call
C.new.hello # => hi from module B
```

`module_function` 还有一个特点，生成的 `ClassMethod`（module functions）是复制了原有的方法，所以再打开类修改该方法的时修改的是可以 `mixin` 的 `InstanceMethod`，`ClassMethod` 不会被改动到，它们是独立的。

```ruby
module Mod
  def one
    "This is one"
  end

  module_function :one
end

class Cls
  include Mod

  def call_one
    one
  end
end

Mod.one      # => This is one
c = Cls.new
c.call_one   # => This is one

module Mod
  def one
    "This is the new one"
  end
end

Mod.one       # => This is one
c.call_one    # => This is the new one
```

之前认为 `module_function` 的功效类似 `extend self`，但仔细探究还是差别很大，如果仅只想转换成 `ClassMethod` 可以用 `extend self`，如果还包含其他情况推荐 `module_function`。

---

* https://ruby-doc.org/core-2.6.3/Module.html
