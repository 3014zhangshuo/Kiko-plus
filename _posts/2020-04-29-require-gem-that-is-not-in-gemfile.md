---
layout: post
title: "如何引入没有在Gemfile中申明的gem"
date: 2020-04-29
tags: [ruby]
---

首先要找到 `gem` 被安装到哪里了，输入 `gem environment`
在输出结果里面找到 `INSTALLATION DIRECTORY`。

第二步在 `rails console` 中把 `INSTALLATION DIRECTORY`
加入到 `ruby` 的 `load path` 中：

```ruby
$: << `INSTALLATION DIRECTORY`
```

---

* https://makandracards.com/makandra/45308-howto-require-gem-that-is-not-in-gemfile
* https://stackoverflow.com/questions/19072070/how-to-find-where-gem-files-are-installed
