---
layout: post
title: 'ssh config file'
date: 2019-05-08
comments: true
tags: []
---

`vim ~/.ssh/config`打开当前用户ssh配置文件，文件默认为空。

基本配置样例：

```
Host qingyun_production
  HostName ip or url
  Port 22
  User root
  IdentityFile ~/.ssh/id_rsa
```

用法：

```shell
ssh qingyun_production

scp ~/Desktop/password.text qingyin_production:~/
```
