---
layout: post
title: "Ruby: next 传一个参数是干什么的"
date: 2020-05-26
tags: [ruby]
---

> `next` can take a value, which will be the value returned for the current iteration of the block.

*参数作为当前循环的返回值*

```ruby
sizes = [0, 1, 2, 3, 4].map do |n|
  next('big') if n > 2
  puts 'Small number detected!'
  'small'
end

puts sizes # => ["small", "small", "small", "big", "big"]
```

---

* https://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-next