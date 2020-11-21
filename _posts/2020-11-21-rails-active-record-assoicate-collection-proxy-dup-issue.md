---
layout: post
title: "ActiveRecord::Associations::CollectionProxy"
date: 2020-11-06
tags: [web]
---

```ruby
self.previous_tags = tags.dup
self.tags = _tags
```

In Rails 4.2.11.3, above code not work as expected, `previous_tags` and `tags`
still reference a same object. (tags.load.dup is incorrect either.)

You need use `to_a` for this suitation

```ruby
self.previous_tags = tags.to_a
self.tags = _tags
```

Everything go well, but `previous_tags` is not `ActiveRecord::Associations::CollectionProxy`

---

* https://github.com/rails/rails/issues/17117
* https://github.com/rails/rails/commit/219402901fd076539ccab47996d51dd5e2ba54e4
