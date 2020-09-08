---
layout: post
title: "Gemfile 中 ~> 是什么含义"
date: 2020-09-08
tags: [ruby]
---

* `'~> 2.0.3'` 相当于 `'>= 2.0.3'` 和 `'< 2.1.'`
* `'~> 2.1'`   相当于 `'>= 2.1'`   和 `'< 3.0'`
* `'~> 2.2.beta'` will match prerelease versions like `2.2.beta.12`

---

* [Bundler Gemfiles Docs](https://bundler.io/gemfile.html)
* [what-does-the-symbol-mean-in-a-bundler-gemfile](https://stackoverflow.com/questions/8699949/what-does-the-symbol-mean-in-a-bundler-gemfile)
