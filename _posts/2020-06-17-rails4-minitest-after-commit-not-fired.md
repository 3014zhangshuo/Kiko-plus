---
layout: post
title: "Rails4 minitest after_commit 没有被触发"
date: 2020-06-17
tags: [mysql]
---

是 `Rails4` 中存在的 `bug`，`use_transactional_fixtures` 启用的时候会引发这个 `bug`。

这样设置可以修复，但是测试会更改测试数据库。

```ruby
class FooTest < ActiveSupport::TestCase
  self.use_transactional_fixtures = false
end
```

`use_transactional_fixtures = true` 的含义：

> In Rails 4.x we have transactional fixtures that wrap each test in a database transaction. This transaction rollbacks all the changes at the end of the test. It means the state of the database, before the test is same as after the test is done.

---

* https://github.com/blowmage/minitest-rails/issues/99
* https://blog.bigbinary.com/2016/05/26/rails-5-renamed-transactional-fixtures-to-transactional-tests.html
* https://makandracards.com/makandra/54733-rails-5-how-to-get-after_commit-callbacks-fired-in-tests
* https://www.justinweiss.com/articles/a-couple-callback-gotchas-and-a-rails-5-fix/
