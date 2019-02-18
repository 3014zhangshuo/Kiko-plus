---
layout: post
title: "Ruby: Case Expressions Pro"
date: 2019-02-17 11:39:22
comments: true
tags: [ruby]
share: false
---
### Ruby `case` 原理

平常我们使用`case`语句时，条件基本都是是否相等、是否在`Range`中、是否匹配正则、是否为类的实例，这些背后的原理都是调用了比较对象的`===`方法。
```ruby
case something
when Array then ...
when 1..100 then ...
when /some_regexp/ then ...
end
# 相当于
case something
when Array === something then ...
when 1..100 === something then ...
when /some_regexp/ === something then...
end
```

### 调用对象的方法进行比较
比方说我们有这样灯这样的一个类，想让如下的`case`语句正常执行，该用什么方法？
```ruby
class Lamp
  def initialize(color)
    @color = color
  end

  def green?
    @color == "green"
  end

  def red?
    @color == "red"
  end

  def yellow?
    @color == "yellow"
  end
end

lamp = Lamp.new("red")

case lamp
when green?
  puts "it's green"
when red?
  puts "it's red"
when yellow?
  puts "it's yellow"
else
  "Unkown color"
end
```

那么我们可以把方法包装成一个`proc`，在`proc`当中`call`相当于`===`

```ruby
is_even = ->(n) { n.even? }
is_even === 5 # => false
# 相当于
is_even.call(5)
```

使用`Proc`

```ruby
case lamp
when -> (x) { x.green? }
  puts "it's green"
when -> (x) { x.red? }
  puts "it's red"
when -> (x) { x.yellow? }
  puts "it's yellow"
else
  "Unkown color"
end
```

### Reference:
[The Many Uses Of Ruby Case Statements](https://www.rubyguides.com/2015/10/ruby-case/)

[Lambdas/Procs in Case Expressions](https://batsov.com/articles/2013/09/24/lambdas-slash-procs-in-case-expressions/)
