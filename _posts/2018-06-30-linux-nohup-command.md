---
layout: post
title: 'Linux: Nohup Command'
date: 2018-06-30 9:30:00
comments: true
tags: [linux]
share: false
---

### nohup 就是不挂起的意思(no hang up)

- 一般形式
`nohup command`

- & 结尾
`nohup command &` 即使terminal关闭，或者本地电脑死机程序依然运行（前提是程序递已经运行到远端无服务上了），会把`标准输出（STDOUT）`和`标准错误（STDERR）`结果输出到`nohup.txt`文件。

### 输出重定向
- `>./command.sh > output` 这其中的`>`就是标准输出符号，其实是`1>output`的缩写

- `>./command.sh 2> output` 这里的`2>`就是将标准错误输出到`output`文件里
- `0<` 则是标准输入

- `>nohup ./command.sh > output 2>&1 &` 把`标准错误（2）`重定向到`标准输出（1）`，而`标准输出`又导入`文件output`里面，结果是标准错误和标准输出都导入文件output里面

- `nohup ./command.sh >output 2>output` 会导致 >output 2>output 文件output被两次打开，而stdout和stderr将会竞争覆盖

### Other Commands
- `jobs` 查看当前有多少在后台运行的命令 `jobs -l`
- `ctrl + z` 可以将一个正在前台执行的命令放到后台，并且暂停。
- `fg %jobnumber` 将后台中的命令调至前台继续运行(jobnumber不是pid)
- `bg %jobnumber` 将一个在后台暂停的命令，变成继续执行(jobnumber不是pid)
- `kill %jobnumber` or `kill pid`

[S](https://www.jianshu.com/p/b5118b70ee1a)
[S](https://my.oschina.net/huxuanhui/blog/13844)

Tips
```
stdout（标准输出），输出方式是行缓冲。输出的字符会先存放在缓冲区，等按下回车键时才进行实际的I/O操作。
stderr（标准错误），是不带缓冲的，这使得出错信息可以直接尽快地显示出来。
```
[S](https://blog.csdn.net/sanjiye/article/details/72796830)
