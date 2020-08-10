---
layout: post
title: "输入 source ~/.zshrc 后 shell 环境崩溃"
date: 2020-05-14
tags: [zsh, shell]
---

今天手贱在终端输入了 `source ~/.zshrc`，发现什么命令都用不了了。

报错：

```
prompt_status:5: command not found: wc
prompt_status:8: command not found: whoami
```

解决办法：

```
PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
export PATH
```

---

https://segmentfault.com/q/1010000007159887/a-1020000009332609
