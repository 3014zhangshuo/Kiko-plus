---
layout: post
title: "Rails: migration 文件的前缀数字是怎么生成的"
date: 2020-09-04
tags: [rails]
---

跑 `rails g migration add_open_userid_to_contact_qywxes` 生成了一个很奇怪 `migration` 文件：`20290615164834_add_open_userid_to_contact_qywxes.rb`，以我之前的理解，`migration` 文件名前缀应该是创建文件时的时间戳啊，怎么是 2029 年了？

查看一下系统时间

```
date

# => Fri Sep  4 15:47:43 CST 2020
```

没问题，那是我之前理解的不对吗？查一下 rails 是按什么逻辑计算出文件名前缀的数字的：

1. 找到文件数字生成的方法

```ruby
# https://github.com/rails/rails/blob/master/activerecord/lib/rails/generators/active_record/migration.rb

# Implement the required interface for Rails::Generators::Migration.
def self.next_migration_number(dirname)
  next_migration_number = current_migration_number(dirname) + 1
  ActiveRecord::Migration.next_migration_number(next_migration_number)
end
```

方法做了什么：
* 找到当前的 `migration number`，然后 +1
* 计算后的 `migration number` 传入 `ActiveRecord::Migration.next_migration_number`

2. 接着看 `current_migration_number` 方法做了什么

```ruby
# https://github.com/rails/rails/blob/master/railties/lib/rails/generators/migration.rb

def current_migration_number(dirname)
  migration_lookup_at(dirname).collect do |file|
    File.basename(file).split("_").first.to_i
  end.max.to_i
end
```

方法做了什么：
* 找出所有的 `migration` 文件
* 列出所有的 `migration number`
* 找到最大的 `migration number`

3. 接着看 `ActiveRecord::Migration.next_migration_number` 方法做了什么


```ruby
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/migration.rb

# Determines the version number of the next migration.
def next_migration_number(number)
  if ActiveRecord::Base.timestamped_migrations
    [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % number].max
  else
    SchemaMigration.normalize_migration_number(number)
  end
end
```

方法做了什么：
* 首先判断是否是用时间戳的格式命名 `migration` 文件，这里我们是 `true`，默认都是时间戳。
* 当前时间戳跟当前 `migration number` 取最大值
  * "%.14d" 补充 number 的位数让其不少于14位，相当于 `format("%.14d", number)`

4. 结论

rails 的确是一部分逻辑是按照当前时间生成 `migration number`，如果当前 `migration number` 没有大于当前时间的。
看来是当前 `migration number` 出了问题。看了一下 migrate 文件的目录，果然上两个文件 `migration number` 分别是 `20290615164832`，`20290615164833`，看来是其他的大兄弟电脑时间出了问题。

5. 题外话

那如果 `timestamped_migrations` 我们设成 `false` 的话，`migration number` 是什么格式呢？

```ruby
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/schema_migration.rb

def normalize_migration_number(number)
  "%.3d" % number.to_i
end
```

看方法是：`001` ... `1000` ....
