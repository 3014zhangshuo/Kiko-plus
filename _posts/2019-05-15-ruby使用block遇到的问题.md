---
layout: post
title: "Ruby: 方法接受 {} 和 do...end 的优先顺序"
date: 2019-05-15
comments: true
tags: [ruby]
share: true
---
在ruby中方法都可以接收一段匿名的`block`代码，申明`block`的方式为`{}`和`do...end`，`{}`对方法的绑定关系上强于`do...end`。
例如：

下面代码可以得到想要的结果，代码块绑定在`map`方法上
```ruby
names = ['bRUce', 'STaN', 'JOlIE']
print names.map { |name| name.downcase }
# => ["bruce", "stan", "jolie"]
```

下面代码则输出了一个`Enumerator`对象，`do...end`绑定在了`print`方法上
```ruby
names = ['bRUce', 'STaN', 'JOlIE']
print names.map do |name| name.downcase end
# => #<Enumerator:0x00007fe0abe878d8>

# 这样也是相同的
print(names.map) { |name| name.downcase }

# 避免这样的错误
print(names.map do |name| name.downcase end)
```

### 参考
[Ruby blocks: Braces and do/end have different precedence](https://makandracards.com/makandra/7871-ruby-blocks-braces-and-do-end-have-different-precedence)
