---
layout: post
title: "Elasticsearch 设置 max result window"
date: 2020-04-29
tags: [elasticsearch]
---

```
curl -H 'Content-Type: application/json' -XPUT localhost:9200/index/_setting -d '{ "index.max_result_window" :"1000000"}'
```

*这里的 `index` 换成的 `table` 名字*

设置成功返回：

```
{"acknowledged":true}
```

---

* https://www.jianshu.com/p/aac37a48b775
