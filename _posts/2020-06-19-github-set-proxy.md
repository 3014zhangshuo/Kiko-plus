---
layout: post
title: "Github 设置代理"
date: 2020-06-17
tags: [网络]
---

配置了 shadowsock 后，github push 就会 Timeout，查了一下，需要设置 github proxy：

```
git config --global https.proxy http://127.0.0.1:1087

git config --global https.proxy https://127.0.0.1:1087

git config --global --unset http.proxy

git config --global --unset https.proxy
```

---

* https://gist.github.com/laispace/666dd7b27e9116faece6
