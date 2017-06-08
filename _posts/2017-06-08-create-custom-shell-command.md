---
layout: post
title: '将常用复制指令定制成shell command'
date: 2017-06-08 11:19
comments: true
tags: [Shell]
comments: true
share: true
---

### 我们每天都有一些需要大量重复执行的命令，为了更高的效率，我们制定一些shell指令来简化我们的输入。

### 如何修改
* iterm每次运行的时候都会取load`~/.profile`(mac平台)`~/.bash_profile`(lunix平台)这个文件。<br />
* 把制定的指令写在这个文件里面就可以被iterm引用到。<br />
* 新增加的命令只能在新开的iterm才能被调用，输入`source ~/.profile`重新载入文件，让指令立即生成。

### 第一种方法 
```
 update_posts() {
    git add .
    git commit -m "update"
    git push origin master
 }
```
这里也可以传参数，shell的第一个参数是`$1`，`echo $1` 

