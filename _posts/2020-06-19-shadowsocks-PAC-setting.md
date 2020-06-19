---
layout: post
title: "Shadowsocks 设置 PAC"
date: 2020-06-19
tags: [网络]
---

You want to add a specific URL to the PAC, not to modify the PAC URL.

Go to Menu > Edit User Rules For PAC, and append your url to the text field. For example:

```
||music.163.com
```

This will make all requests to `music.163.com` to go through the proxy.

---

* https://www.zybuluo.com/yiranphp/note/632963
* https://github.com/shadowsocks/ShadowsocksX-NG/issues/437
