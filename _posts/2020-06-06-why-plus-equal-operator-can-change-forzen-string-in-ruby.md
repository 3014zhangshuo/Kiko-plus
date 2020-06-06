---
layout: post
title: "Ruby: 为什么 += 可以改变 frozen string"
date: 2020-06-06
tags: [ruby]
---

因为 `a += 1` 只是 `a = a + 1` 的语法糖，等号左边的 `a` 跟等号右边的 `a` 不是一个对象，它重新生成了一个对象。

---

* https://stackoverflow.com/questions/41375818/operator-appears-to-modify-frozen-string
* http://rubylearning.com/satishtalim/mutable_and_immutable_objects.html
