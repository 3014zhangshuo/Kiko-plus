---
layout: post
title: "恢复 git rebase 合并的 commit"
date: 2020-06-06
tags: [git]
---

* 第一步：使用 `git reflog` 找到开始 `rebase` 前的 `head commit`。

```
becbea1 HEAD@{10}: rebase -i (start): checkout HEAD~2
99c016e HEAD@{11}: checkout: moving from master to ts_5360
```

这里的 `HEAD@{11}` 就是我们需要找到的，还可以用 `git log HEAD@{11}` 查看当时的分支状态。

* 第二步：使用 `git reset --hard HEAD@{11}` 恢复之前的分支状态。

---

* https://stackoverflow.com/questions/134882/undoing-a-git-rebase
