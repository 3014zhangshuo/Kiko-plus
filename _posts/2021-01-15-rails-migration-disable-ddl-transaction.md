---
layout: post
title: "Rails: 什么时候使用 disable_ddl_transaction!"
date: 2021-01-15
tags: [rails db]
---

Rails migration 执行的时候默认被包裹一层 transaction，为了任何语句报错后，回滚所有成功的。

那如何去掉 transaction，加一行 `disable_ddl_transaction!` 就可以了。

那什么场景下需要使用 `disable_ddl_transaction!` ？

如果要给一个数据量很大的表加索引，执行时间很久的话，就需要。因为增加索引的时候数据库会锁表，
这时候用户不可以写数据了，需要加创建索引的时候使用配置：`algorithm: :concurrently` 来处理，
配置这个的时候，执行的时候就不能包裹在 transaction 里面了。

`algorithm: :concurrently` 和 `disable_ddl_transaction!` 是组合使用的。

```ruby
class AddIndexOnBatchIdToFundTrades < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :fund_trades, :batch_id, algorithm: :concurrently
  end
end
```

---

* [how-to-add-index-to-a-large-working-app-on-rails](https://jetrockets.pro/blog/kbz5cbkded-how-to-add-index-to-a-large-working-app-on-rails)
* [differences-between-transactions-and-locking](https://makandracards.com/makandra/31937-differences-between-transactions-and-locking)
