---
layout: post
title: "rbenv rehash 起什么作用"
date: 2020-05-26
tags: [ruby]
---

> rbenv creates shims for all the commands (ruby, irb, rake, gem and so on) across all your installed versions of Ruby. This process is called rehashing. Every time you install a new version of Ruby or install a gem that provides a command, run rbenv rehash to make sure any new commands are shimmed.

每次安装新的 `Gem` 都需要执行 `rbenv rehash` 刷新当前 `shell commands`。

*现在 `rbenv` 会自动执行 `rehash`*

---

* https://stackoverflow.com/questions/9394338/how-do-rvm-and-rbenv-actually-work
* https://teamtreehouse.com/community/what-does-rbenv-rehash-mean-exactly