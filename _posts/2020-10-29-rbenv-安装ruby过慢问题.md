---
layout: post
title: "Ruby: rbenv 安装过慢问题"
date: 2020-10-29
tags: [ruby]
---

去 ruby China 提供的[镜像地址](https://cache.ruby-china.com/pub/ruby/)下载想要的版本，
移动到 `./rbenv/cache`：

```shell
mv ruby-2.3.3.tar.bz2 ~/.rbenv/cache/
```

然后执行命令安装就可以了：

```shell
RUBY_BUILD_HTTP_CLIENT=curl rbenv install 2.3.3
```
---

* [解决rbenv install安装过慢的问题](https://blog.csdn.net/shine_a/article/details/103927374)
