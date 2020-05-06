---
layout: post
title: "Git: 合并多个commit"
date: 2020-05-06
tags: [git]
---

一个任务票有多个 `commit`，如：

```
0e873b1 ZZ-5212 客户无法付款 FIX 3
i2cfeb7 ZZ-5212 客户无法付款 FIX 2
e7d7162 ZZ-5212 客户无法付款 FIX 1
450f6e8 ZZ-5211 添加微信付款流程
```

想把任务 `ZZ-5212` 的多个 `commit` 合并成一个：

#### 先选定合并的commit

```
git rebase -i HEAD~3
```

或者

```
git rebase -i 450f6e8
```

*`git rebase -i` 需要一个 `startpoint` 和 `endpoint` 来指定了一个编辑区间，如果不指定 `endpoint`，则该区间的终点默认是当前分支 `HEAD` 所指向的 `commit`*

#### 合并commmit

```
pick e7d7162 ZZ-5212 客户无法付款 FIX 1
s i2cfeb7 ZZ-5212 客户无法付款 FIX 2
s 0e873b1 ZZ-5212 客户无法付款 FIX 3

# Rebase 0e873b1..e7d7162 onto e7d7162(3 commands)
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

#### 重新编写commit message

```
ZZ-5212 客户无法付款
```

#### 如何放弃合并 commit

* 如果刚进入 `git rebase -i HEAD~3`，可以输入 `:cq` 退出编辑器。
* 如果已经合并了 `commit`，处在重新编写 `commit message` 的时候，可以关闭编辑器，重新开一个窗口输入 `git rebase --abort`。
* 如果已经完成了 `commit` 的合并，那要先找到想恢复的 `commit hash` 值，输入 `git reset --hard COMMIT_HASH`

---

* https://stackoverflow.com/questions/33557776/git-cancel-an-interactive-rebase
