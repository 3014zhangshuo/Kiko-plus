---
layout: post
title: "Rails Api: transaction_include_any_action?"
date: 2020-04-23
tags: [rails]
---

在项目中看到一个从没用到的方法 `transaction_include_any_action?(actions)`，查了一
下多用于`after_commit` 这个回调中，用来检查记录的状态：已创建(created)、
已更新(updated)、已销毁(destroy)。

大概用法如下：
```ruby
class User
  after_commit :do_something

  def do_something
    if transaction_include_any_action?([:create])
      # handle create
    elsif transaction_include_any_action?([:update])
      # handle update
    elsif transaction_include_any_action?([:destroy])
      # handle destroy
    end
  end
end
```

总体感觉这个api没什么用，这样的实现耦合了代码。
其实可以用 `after_commit: :do_something, on: :update` 这种方式解决。

---

* https://stackoverflow.com/questions/37100451/know-what-event-triggered-the-after-commit-of-an-activerecord-model
* https://stackoverflow.com/questions/41394887/rails-4-after-commit-nested-conditions-issue
* https://github.com/rails/rails/blob/d03d6fc33b4e9629e3e969c18bda4bdcd3c01c90/activerecord/lib/active_record/transactions.rb#L442
