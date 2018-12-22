---
layout: post
title: 'Linux: File Permission'
date: 2018-12-21 11:39:22
comments: true
tags: [linux]
share: false
---

Permission   | Binary | Octal  | Description
------------ | ------ | ------ | ------------
---          | 000    | 0      | No permission
--x          | 001    | 1      | Only execute
-w-          | 010    | 2      | Only write
r--          | 011    | 3      | Only read
rw-          | 100    | 4      | Read and write
-wx          | 101    | 5      | Write and execute
r-x          | 110    | 6      | Read and execute
rwx          | 111    | 7      | All permission

### Reference:
* [linux文件权限查看及修改-chmod](https://blog.csdn.net/haydenwang8287/article/details/1753883)
* [理解Linux文件权限](https://www.jianshu.com/p/8566a74e77be)
