---
layout: post
title: 'When to use constants instead of instance variables in Ruby?'
date: 2018-04-25 11:05:37
comments: true
tags: [Ruby]
comments: true
share: true
---
First, you should consider:
* Will the value change within the life-cycle of an object?
* Will you need to override the value in sub-classes?
* Do you need configure the value at run-time?

The best kind of constants are those that don't really change short of updating the software:
```
class ExampleClass
  STATES = %i[
    off
    on
    broken
  ].freeze
end
```
Generally you use these constants internally in the class and avoid sharing them. When you share them you're limited in how they're used. For example, if another class referenced `ExampleClass::STATES` then you can't change that structure without changing other code.

You can make this more abstract by providing an interface:
```
class ExampleClass
  def self.states
    STATES
  end
end
```

If you change the structure of that constant in the future you can always preserve the old behaviour:
```
class ExampleClass
  STATES = {
    on: 'On',
    off: 'Off',
    broken: 'Broken'
  }.freeze

  def self.states
    STATES.keys
  end
end
```

COPY form [原文](https://stackoverflow.com/questions/29927103/when-to-use-constants-instead-of-instance-variables-in-ruby)
