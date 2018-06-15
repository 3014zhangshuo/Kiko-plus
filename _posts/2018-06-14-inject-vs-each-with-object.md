---
layout: post
title: 'inject and each_with_object'
date: 2018-06-14 00:00:00
comments: true
tags: [Ruby]
share: false
---

### Enumerable#inject

* better for operations on mutable objects/collections which return a new value
* good for immutable primitives and value objects which return a new value when changed

### Enumberable#each_with_object

* better for mutable operations on objects/containers
  * especially such as Hash, Array
* it makes sense to use it if you provide a fresh object as a starting point and build it
  * not that useful if you want to modify an existing object

#### Example 1
build new hash
```
lower = 'a'..'z'
lower_to_upper = lower.each_with_object({}) do |char, hash|
  hash[char] = char.upcase
end
```
```
lower = 'a'..'z'
lower_to_upper = lower.inject({}) do |hash, char|
  hash[char] = char.upcase
  hash
end
```

because `inject` requires that the memoized value provided for subsequent block calls (`hash` which initially is `{}`) is returned by previous block calls. So even though you constantly operate on the same object, you always need to return it in the last line of the provided block.

`each_with_object` on the other hand always calls the block with the same initial object that was passed first as first argument to the method.

#### Example 2
modify existing object
```
mapping = {'ż' => 'Ż', 'ó' => 'Ó'}
lower = 'a'..'z'
lower.each do |char|
  mapping[char] = char.upcase
end
return mapping # optionally
```
```
mapping = {'ż' => 'Ż', 'ó' => 'Ó'}
lower = 'a'..'z'
lower.each_with_object(mapping) do |char, hash|
  hash[char] = char.upcase
end
```
```
mapping = {'ż' => 'Ż', 'ó' => 'Ó'}
lower = 'a'..'z'
lower.each_with_object(mapping) do |char|
  mapping[char] = char.upcase
end
```

#### Example 3
This time you are not mutating internal state of an object but rather always creating a new one. The operation that you use always returns a new object.
```
a = 1
b = 2

a.frozen?
# => true
b.frozen?
# => true

c = a + b
# => 3
```
There is no way to change the Integer object referenced by variable a into 3. The only thing you can do is assign a different object to variable a or b or c.
```
require 'date'
d = Date.new(2017, 10, 10)
```
If you want a different date, you cannot change the existing Date instance. You need to create a new one.
```
d.day=12
# => NoMethodError: undefined method `day=' for #<Date:

e = Date.new(2017, 10, 12)
```
If your initial object is immutable, inject is the way to go.
```
(5..10).inject(:+)
(5..10).inject(0, :+)
(5..10).inject{|sum, n| sum + n }

(5..10).inject(1, :*)
```

```
starting_date = Date.new(2017,10,1)
result = [1, 10].inject(starting_date) do |date, delay|
  date + delay
end
# => Date.new(2017,10,12)
```

```
# gem install money
require 'money'
[
  Money.new(100_00, "USD"),
  Money.new( 10_00, "USD"),
  Money.new(  1_00, "USD"),
].inject(:+)
# => #<Money fractional:11100 currency:USD>
```

#### Example 4
This time we will be creating a new object every time but not because we can’t change the internal state. This time it’s because a certain method returns a new object.
```
result = [
 {1 => 2},
 {2 => 3},
 {3 => 4},
 {1 => 5},
].inject(:merge)
# => {1=>5, 2=>3, 3=>4}
```

```
[
 {1 => 2},
 {2 => 3},
 {3 => 4},
 {1 => 5},
].each_with_object({}) {|element, hash| hash.merge!(element) }
# => {1=>5, 2=>3, 3=>4}
```

[S](https://blog.arkency.com/inject-vs-each-with-object/)
