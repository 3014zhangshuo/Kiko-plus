---
layout: post
title: "如何引入没有在Gemfile中申明的gem"
date: 2020-04-29
tags: [ruby]
---

首先要找到 `gem` 被安装到哪里了，输入 `gem which activerecord-import`，
输出 `/Users/zhangshuo/.rbenv/versions/2.6.5/gemsets/myapp/gems/activerecord-import-1.0.4/lib/activerecord-import.rb`

第二步在 `rails console` 中把地址加入到 `ruby` 的 `load path` 中：

```ruby
# 这里只指定到 lib

$: << '/Users/zhangshuo/.rbenv/versions/2.6.5/gemsets/udesk_proj/gems/activerecord-import-1.0.4/lib'
```

---

* https://makandracards.com/makandra/45308-howto-require-gem-that-is-not-in-gemfile
* https://stackoverflow.com/questions/19072070/how-to-find-where-gem-files-are-installed
