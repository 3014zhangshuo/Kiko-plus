---
layout: post
title: "Linux 中的文件类型"
date: 2020-09-09
tags: [linux]
---

+ 普通文件
+ 目录文件
+ 特殊文件
  + pipe
  + socket
  + symlink
  + chardev
  + blockdev


`普通文件` 和 `目录文件` 比较好理解，下面仔细说一下 5 种特殊文件各自的含义：

* pipe     -> 用于系统进程间通信的文件
* socket   -> 进程之间通过网络进行通信的文件，多数网络连接都是用 socket 建立的
* symlink  -> 软连接
* chardev  -> 字符设备文件：硬盘、软盘、CD-ROM驱动器和闪存都是典型的块设备
* blockdev -> 块设备文件：键盘、串口、调制解调器都是典型的字符设备

---

* [怎样理解和识别 Linux 中的文件类型](https://zhuanlan.zhihu.com/p/62268929)
* [文件类型](http://linux-wiki.cn/wiki/zh-tw/符号链接)
* [字符设备、块设备与网络设备](https://www.jianshu.com/p/477c5b583fbe)
