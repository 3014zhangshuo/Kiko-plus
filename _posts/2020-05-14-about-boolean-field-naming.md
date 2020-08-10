---
layout: post
title: "关于 boolean column 命名问题"
date: 2020-05-14
tags: [ruby, rails, code-style]
---

开始学 `rails` 的时候被教导过 `boolean column` 的名字要以 `is_` 做前缀，像这样 `is_admin`。
但最近总感觉这样的命名有些不对劲，就像小学写作文，老师会把~~我的~~妈妈说过中的我的批注掉，总有些脱裤子放屁的感觉。

最近在项目中就纠结是用 `is_enable_desktop_notification` 还是 `enable_desktop_notification`，看了几个讨论的帖子，大概有这几个方面：

* 以 `is` 开头是一种更简单回答 true / false 的方式，直接呼叫 `is_admin`
* `admin` 这种命名在 rails 中更像一个 scope
* 在 rails 中会为 `boolean column` 自动添加问号方法，`admin` 这样更符合 rails 的约定

我选择了没有 `is` 的命名，`enable_desktop_notification?` 比 `is_enable_desktop_notification?` 要优雅。关于是否像 scope，是，看起来的确像是 scope，但是考虑调用的对象，这种歧义应该是没有的。

---
* https://stackoverflow.com/questions/3112078/rails-boolean-fields-is-foo-or-just-foo
* https://stackoverflow.com/questions/37059547/naming-conventions-for-boolean-attributes/37060624
