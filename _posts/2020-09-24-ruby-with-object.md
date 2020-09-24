---
layout: post
title: "Ruby: with_object method"
date: 2020-09-24
tags: [ruby]
---

```ruby
to_three = Enumerator.new do |y|
  3.times do |x|
    y << x
  end
end

to_three_with_string = to_three.with_object("foo")
to_three_with_string.each do |x, string|
  puts "#{string}: #{x}"
end

# => foo:0
# => foo:1
# => foo:2

Hash[%w[foo bar].map.with_object(true).to_a]
# => {"foo"=>true, "bar"=>true}
```

Q. What's the difference between `enum#with_object` and `enum#each_with_object`?

A. `with_object` only works on enumerators, which means that you have to chain it on to something that returns one，example：

```ruby
%w(foo bar).each.with_object({}) { |str, h| h[str] = str.upcase }
# => {"foo"=>"FOO", "bar"=>"BAR"}
```

`each_with_object` is essentially an alias for `each.with_object`.

---

* [ruby/Enumerator/with_object](https://apidock.com/ruby/Enumerator/with_object)
* [how-does-enumwith-object-differ-from-enumeach-with-object](https://stackoverflow.com/questions/14671881/how-does-enumwith-object-differ-from-enumeach-with-object/14672305#14672305)
