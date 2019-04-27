---
layout: post
title: "Ruby: Closures"
date: 2019-04-17 21:39:22
comments: true
tags: [ruby]
share: false
---
###
adder = proc { |a| proc { |b| a + b } }
add3 = adder.call(3)
[1, 2, 3].map(&add3)
### Counter
```ruby
class Counter
  attr_reader :count

  def initialize(count=0)
    @count = count
  end

  def increment(n = 1)
    @count += 1
  end
end

c = Counter.new

c.increment
c.increment
```

```ruby
counter = proc {
  count = 0
  {
    increment: proc { |n = 1| count += n }
  }
}

c = counter.call
c[:increment].call
c[:increment].call
```
```ruby
counter = (1..Float::INFINITY).to_enum
counter.next
counter.next

counter = (1..Float::INFINITY).step(5).to_enum
counter.next
counter.next
```

```ruby
class Adder
  def initialize(n)
    @n = n
  end

  def to_proc
    proc { |v| @n + v }
  end
end

[1, 2, 3].map(&Adder.new(5))
```

```ruby
class Adder
  def initialize(n)
    @n = n
  end

  def to_proc
    proc { |v| @n + v }
  end

  def call(v)
    self.to_proc.call(v)
  end

  alias_method :===, :call

  class << self
    def call(n)
      new(n)
    end

    alias_method :[], :call
  end
end

[1, 2, 3].map(&Adder[15])
[1, 2, 3].map(&Adder.(7))
```

### Reference
[Ruby Functional Programming](https://medium.com/@baweaver/functional-programming-in-ruby-closures-ac80547eb40d)



