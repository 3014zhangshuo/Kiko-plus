---
layout: post
title: "Reek: Control Couple"
date: 2019-02-21 11:39:22
comments: true
tags: [ruby, reek]
share: false
---
> Control coupling occurs when a method or block checks the value of a parameter in order to decide which execution path to take.


```ruby
class DefaultValue

  def initialize(value)
    @value = value
  end

  def evaluate(instance)
    if callable?
      call(instance)
    elsif duplicable?
      @value.dup
    else
      @value
    end
  end
end
```

```ruby
class DefaultValue
  DESCENDANTS = [FromSymbol, FromCallable, FromClonable].freeze

  def self.build(value)
    klass = DESCENDANTS.detect { |descendant| descendant.handle?(value) } || self
    klass.new(value)
  end

  def initialize(value)
    @value = value
  end

  def call
    @value
  end
end
```

### Reference:

[Control Couple](https://github.com/troessner/reek/blob/master/docs/Control-Couple.md)
