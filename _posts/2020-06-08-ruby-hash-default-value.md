---
layout: post
title: "Ruby Hash.new(default) 默认值问题"
date: 2020-06-08
tags: [ruby]
---

我们可以用 `Hash.new({})` 来指定默认值为 `{}`，这样如果查询没有声明的 `key` 值，会返回默认值：

```ruby
h = Hash.new({})
h[:name] #=> {}
```

默认值指的是同一个引用（同一个 `object` 或者可以说 同一个内存地址），这样就会有意外发生，比如这里你期望的 `r[:c]` 返回的是 `{}`：

```ruby
r = {
  a: { aa: 1, aaa: 2 },
  b: { bb: 1, bbb: 2 }
}.each_with_object(Hash.new({})) do |(k, v), hash|
  hash[k][v.first.first] = v.first
end

# 这里会返回 {}，不要惊慌，这是 Hash.new({}) 的返回值，这里的 hash 已经构建完了
# r[:a] 会返回 {:aa=>[:aa, 1], :bb=>[:bb, 1]}

r[:c] #=> {:aa=>[:aa, 1], :bb=>[:bb, 1]}
```

解决这种情况的你需要指定每一个 `key` 的默认值都是一个新的对象：

```ruby
Hash.new { |hash, key| hash[key] = {} }
```

---

* https://stackoverflow.com/questions/28915443/how-does-each-with-objecthash-new-work
