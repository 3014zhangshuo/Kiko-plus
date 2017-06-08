---
layout: post
title: '配置git diff的输出颜色'
date: 2017-06-08 10:40
comments: true
tags: [Git]
share: true
---
### 将配置添加到~/.gitconfig
```
[color "diff"]
	meta = white reverse
	frag = cyan reverse
	old = red bold
	new = green bold
```

#### 颜色参数的取值
* normal
* black
* red
* green
* yellow
* blue
* magenta
* cyan
* white

#### 颜色属性的配置取值
* bold
* dim
* ul
* blink
* reverse

[摘抄地址](http://ericnode.info/post/colorize_git_diff/)