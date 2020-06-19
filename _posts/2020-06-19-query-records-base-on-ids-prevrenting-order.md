---
layout: post
title: "按照 ids 数组查询数据，结果按数组内顺序排序（仅限 MySQL）"
date: 2020-06-19
tags: [sql]
---

```ruby
ids = [100, 1, 6]
User.where(:id => ids).order("field(id, #{ids.join(',')})").map(&:id)
# => [100, 1, 6]
```

---

* https://kinopyo.com/en/blog/finding-an-array-of-ids-while-keeping-the-order-with-rails
