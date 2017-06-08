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
* iterm每次运行的时候都会取load`~/.profile`(mac平台)`~/.bash_profile`(lunix平台)这个文件。
* 把制定的指令写在这个文件里面就可以被iterm引用到。
* 新增加的命令只能在新开的iterm才能被调用，输入`source ~/.profile`重新载入文件，让指令立即生成。

### 第一种方法 自定命令
```
 update_posts() {
    git add .
    git commit -m "update"
    git push origin master
 }
```
这里也可以传参数，shell的第一个参数是`$1`，`echo $1` 

### 第二种方法 命令别名

`alias cv="cd /Users/someone/project"`

### 第三种方式 制定脚本
创建bin文件夹，编写自己的shell script。
* `mkdir bin`
* `cd bin`, `vim common_cmd`
* `chmod +x common_cmd` <mark>更改文件权限，让文件变成可执行的</mark>
* 系统是不会认识我们新增的指令的，修改系统环境变量，让命令可执行。输入 `echo $PATH` 查看所有的系统变量，<br />修改`~/.profile`修改加载路径`export PATH=\Users\zhangshuo\bin:$PATH`,引入自定义的路径并追加原有的路径。



