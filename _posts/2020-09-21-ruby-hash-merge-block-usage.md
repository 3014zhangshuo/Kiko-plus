---
layout: post
title: "Ruby hash merge 传递代码块的例子"
date: 2020-09-21
tags: [ruby]
---

```ruby
defaults = { a: 1, b: 2, c: 3 }
preferences = { c: 4 }

defaults.merge(preferences) { |key, old_value, new_value| [old_value, new_value].max }
```

---

* [ruby-hash-methods](https://www.rubyguides.com/2020/05/ruby-hash-methods/)
