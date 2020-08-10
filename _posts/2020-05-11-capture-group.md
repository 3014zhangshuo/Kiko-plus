---
layout: post
title: "Capture Group(捕获组)"
date: 2020-05-11
tags: [ruby, regexp]
---

* 普通捕获组：`(Expression)`
* 命名捕获组：`(?<name>Expression)`

这里说一下命名捕获组在 `ruby` 中的使用：

```ruby
regexp = /\A(?<year>{YYYY})(?<month>{MM})(?<day>{DD})\z/

result = '{YYYY}{MM}{DD}'.match(regexp)

result[:year]  # => {YYYY}
result[:month] # => {MM}
result[:day]   # => {DD}
```

这样做可以增强代码的可读性。

---

* https://blog.csdn.net/lxcnn/article/details/4146148
