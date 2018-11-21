---
layout: post
title: 'Ruby: extend self'
date: 2018-08-11 11:28:00
comments: true
tags: [ruby]
share: false
---

### Class is meant for both data and behavior
```
class Util
  def self.double(i)
    i*2
  end
end
```
The `Util` class methods are class methods. This class does not have any instance variables. Usually a class is used to carry both data and behavior and ,in this case, the `Util class` has only behavior and no data.

### Similar utility tools in ruby
```
require 'base64'
Base64.encode64('hello world') #=> "aGVsbG8gd29ybGQ=\n"

require 'benchmark'
Benchmark.measure { 10*2000 }

require 'fileutils'
FileUtils.chmod 0644, 'test.rb'

Math.sqrt(4) #=> 2

Base64.class #=> Module
Benchmark.class #=> Module
FileUtils.class #=> Module
Math.class #=> Module
```
Class is too heavy for creating only methods like double. If the only thing you care about is behavior then ruby suggests to implement it as a module.

### module class methods
```
module Util
  extend self

  def double(i)
    i * 2
  end
end

puts Util.double(4) #=> 8

module Util
  def self.double(i)
    i * 2
  end
end

module Util
  class << self
    def double(i)
      i * 2
    end
  end
end
```

### Another usage inline with how Rails uses extend self
An ecommerce application and each new order needs to get a new order number from a third party sales application.
```
class Order
  def amount; end
  def buyer; end
  def shipped_at; end
  def number
    @number || self.class.next_order_number
  end

  def self.next_order_number; 'A100'; end
end

puts Order.new.number #=> A100
```
Here the method `next_order_number` might be making a complicated call to another sales system. Ideally the `class Order` should not expose method `next_order_number` . So we can make this method `private` but that does not solve the root problem. The problem is that model `Order` should not know how the new order number is generated. Well we can move the method `next_order_number` to another `Util class` but that would create too much distance.

```
module Checkout
  extend self

  def next_order_number; 'A100'; end

  class Order
    def amount; end
    def buyer; end
    def shipped_at; end
    def number
      @number || Checkout.next_order_number
    end
  end
end

puts Checkout::Order.new.number #=> A100
```

The `class Order` is not exposing method `next_order_number` and this method is right there in the same file. No need to open the `Util class`.

[1](https://blog.bigbinary.com/2012/06/28/extend-self-in-ruby.html)
