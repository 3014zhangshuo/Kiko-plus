---
layout: post
title: "Rails: Restrict with error or exception"
date: 2019-03-01 11:39:22
comments: true
tags: [rails]
share: false
---
> 为了阻止已关联的记录被删除，`ActiveRecord`提供了`restrict_with_exception`和`restrict_with_error`这两种方式。

### restrict_with_exception
```ruby
class Company < ActiveRecord::Base
  has_many :works, dependent: :restrict_with_exception
end

Company.first.destroy # => ActiveRecord::RecordNotDestroyed: Failed to destroy the record
```
ROLLBACK并抛出异常，终止后续的程序执行

### restrict_with_error
```ruby
class Company < ActiveRecord::Base
  has_many :works, dependent: :restrict_with_error
end

company = Company.first
company.destroy
# ROLLBACK
company.errors # => ...@messages={:base=>["由于 works 需要此记录，所以无法移除记录"]}...
```
ROLLBACK把错误信息`errors`添加到调用的对象上

### Reference:
[Difference between restrict_with_exception and restrict_with_error](https://stackoverflow.com/questions/48071054/difference-between-restrict-with-exception-and-restrict-with-error)
