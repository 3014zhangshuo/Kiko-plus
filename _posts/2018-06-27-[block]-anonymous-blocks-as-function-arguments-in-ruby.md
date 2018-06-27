---
layout: post
title: 'Block Arguments'
date: 2018-06-27 00:00:00
comments: true
tags: [Ruby]
share: false
---

### Familiar Ruby Method Using Blocks To Scope Code Execution
- {}
  ```
  [1,2,3].each { |n| puts n }
  # >> 1
  # >> 2
  # >> 3
  ```
- do..end
  ```
  10.times do
    puts 'hello'
  end
  ```

`each` and `times` that accept a block as a parameter, In fact any Ruby method does accept a block, it will just ignore it unless it's told to do something with it.

### Simple Block Function

```
def eat(something)
  'good'
end

p eat('apple') # >> "good"

# block with parameter
p eat('apple') { |food| "m #{food}" } # >> "good"
```

### Two ways to execute a block passed function `.yield` and `.call`

- yield

```
def eat(meal)
  meal.each { |food| yield(food) }
  'delicious!'
end

puts eat(['cheese', 'steak', 'wine']) {|food| puts "Mmm, #{food}"}
# >> Mmm, cheese
# >> Mmm, steak
# >> Mmm, wine
# >> delicious!

puts eat(['cheese', 'steak', 'wine']) # >> LocalJumpError: no block given (yield)
```

our function to call out to a passed block, but it isn’t optional

```
def eat(meal)
  meal.each { |food| yield(food) } if block_given?
  'delicious!'
end

puts eat(['cheese', 'steak', 'wine']) {|food| puts "Mmm, #{food}"}
# >> Mmm, cheese
# >> Mmm, steak
# >> Mmm, wine
# >> delicious!

puts eat(['cheese', 'steak', 'wine']) # >> delicious
```

- call
A block argument has to be last, and has to be prepended with an ampersand (&). The & is a bit of magic that converts the anonymous block into a Proc that we can directly reference.

```
def eat(meal, &consume)
  meal.each { |food| consume.call(food) } if block_given?
  'delicious!'
end
```

```
def eat(meal, &consume)
  meal.each { |food| consume.call(food) } if consume?
  'delicious!'
end
```

Turns out: converting the passed block into a Proc is expensive. If all you are doing with the Proc is calling it, you should consider switching that to the yield syntax. But you do get something cool out of converting to a Proc object: a Proc object. You can call it, store it, pass it somewhere else, or introspect it for doing something clever.
```
def eat(meal, &consume)
  if consume
    # only call a block with parameters
    unless consume.parameters.empty?
      meal.each {|food| consume.call(food)}
    end
  end
  'delicious!'
end

puts eat(['cheese', 'steak', 'wine']) {|food| puts "Mmm, #{food}"}
# >> Mmm, cheese
# >> Mmm, steak
# >> Mmm, wine
# >> delicious!

puts eat(['cheese', 'steak', 'wine']) { puts "Mmm" }
# Nothing printed because our method spurns blocks without parameters.

puts eat(['cheese'])
# >> delicious!
```
[S](http://www.rakeroutes.com/blog/anonymous-blocks-as-function-arguments-in-ruby/)
