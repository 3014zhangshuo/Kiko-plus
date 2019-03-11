---
layout: post
title: "Ruby: All? Method Caused BUG"
date: 2019-03-09 11:39:22
comments: true
tags: [ruby]
share: false
---
### 问题描述

有一张记录关注公众号用户的表，要实现定时给关注非注册用户发送微信图文消息，如果用户取关则不执行发送程序，如下是实现代码。
```ruby
accounts = WechatOfficialAccount.wondercv.subscribes.where(openid: openid)

if accounts.all? { |account| account.user.blank? }
  Onboarding::WechatCustomNews.new(openid).send
end
```
但今天检查后台任务发现很多的发送任务都在retry，具体原因是发送的用户已经取关了。检查了记录取关的代码是正常工作的，仔细看上面的代码发现如果`accounts`为空时会不会返回的是`true`，一试果然，本来的直觉认为是`false`。

### all?
> Passes each element of the collection to the given block. The method returns true if the block never returns false or nil. If the block is not given, Ruby adds an implicit block of {|obj| obj} (that is all? will return true only if none of the collection members are false or nil.)

如果调用对象为空时，`block`是不会被执行的，不会返回`nil`或者`false`，`all?`方法就会返回`true`。

### 解决办法
```ruby
if accounts.any? && accounts.all? { |account| account.user.blank? }
  Onboarding::WechatCustomNews.new(openid).send
end
```

### any?
> Passes each element of the collection to the given block. The method returns true if the block ever returns a value other than false or nil. If the block is not given, Ruby adds an implicit block of {|obj| obj} (that is any? will return true if at least one of the collection members is not false or nil.

`accounts.any?`没有给定执行的`block`，`ruby`会添加一个隐形的`block`。`any?`返回`true`需要`block`返回非`nil`或者`false`，由于`accounts`为空，`block`没有被执行，`any?`返回`false`。

### Reference:

[Why does .all? return true on an empty array?](https://stackoverflow.com/questions/16662727/why-does-all-return-true-on-an-empty-array)

[Enumerable Doc](http://ruby-doc.org/core-1.9.3/Enumerable.html)
