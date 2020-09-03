---
layout: post
title: "Ruby: 关于 hash 的 key"
date: 2020-09-02
tags: [ruby]
---

整理 Ruby 红宝书的一个知识点，使用数值或者自己定义的类等对象作为 hash 的 key 需要注意的地方，先看下面👇的代码

```ruby
h = Hash.new
n1 = 1
n2 = 1.0
p n1 == n2 # => true

h[n1] = 'exists.'
p h[n1] # => exists.
p h[n2] # => nil
```

##### 为什么 n1 和 n2 相等，n2 却无法在 hash 中找到相应的值？
> 因为 hash 判断两个 key 是否一致是，要判定 `key1.hash == key2.hash` 和 `key1.eql?(key2) == true`。`1.hash` 与 `0.1.hash` 值并不相等。


##### 自定义类的对象上

```ruby
class User
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

h = Hash.new

u1 = User.new('zhangshuo')
u2 = User.new('zhangshuo')

h[u1] = 'exists.'
p h[u1] # => 'exists.'
p h[u2] # => nil
```

如果我们想以相同 `name` 的 `user` 视为 `hash` 中相等的 `key`，就要重新定义 `eql?` 和 `hash` 方法

```ruby
class User
  def ==(other)
    self.class === other && name == other.name
  end

  alias eql? ==

  def hash
    name.hash
  end
end

h = Hash.new

u1 = User.new('zhangshuo')
u2 = User.new('zhangshuo')

h[u1] = 'exists.'
p h[u1] # => 'exists.'
p h[u2] # => 'exists.'
```

---

* [ruby-doc-Hash+Keys](https://ruby-doc.org/core-2.7.1/Hash.html#class-Hash-label-Hash+Keys)
