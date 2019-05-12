---
layout: post
title: '在Bash Function参数使用默认值'
date: 2019-05-11
comments: true
tags: []
share: false
---

### 官方文档
```
${parameter:-word}
  Use Default Values.
	If parameter is unset or null, the expansion of word is substituted.
	Otherwise, the value of parameter is substituted.
```

### 例子
```bash
updateBlog() {
   message=${1:-update}
   git add _posts
   git commit -m $message
   git push origin master
}
```

### 参考：
[Optional parameters in bash function](https://unix.stackexchange.com/questions/274175/optional-parameters-in-bash-function)
