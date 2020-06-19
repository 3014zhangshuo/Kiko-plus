---
layout: post
title: "rails c 无法启动（LoadError: libreadline.7.dylib）"
date: 2020-06-19
tags: [rails]
---

错误：

```
Library not loaded: /usr/local/opt/readline/lib/libreadline.7.dylib (LoadError)
```

解决办法：

```
cd /usr/local/opt/readline/lib/ # 进入目录，看看安装了哪个版本，我这里是 8.0

ln -s /usr/local/opt/readline/lib/libreadline.8.0.dylib /usr/local/opt/readline/lib/libreadline.7.dylib
```

---

* https://github.com/rails/rails/issues/26658
