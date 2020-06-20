---
layout: post
title: "abstract_class = true 是什么含义"
date: 2020-06-20
tags: [rails]
---

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

当你需要继承 `ActiveRecord::Base` 但是没有相对应可以映射的 `table` 时，需要加 `self.abstract_class = true`，没有这个功能之前你想扩展一下 `ActiveRecord` 你需要这样
`ActiveRecord::Base.include(ExtendARModule)`。


---

* https://ruby-china.org/topics/32100
