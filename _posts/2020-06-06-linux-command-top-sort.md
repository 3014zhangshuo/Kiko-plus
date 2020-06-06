---
layout: post
title: "top 指令结果按指标排序"
date: 2020-06-06
tags: [linux]
---

以内存大小排序

Mac:

```
top -o MEM   # 默认从大到小
top -o +MEM  # 从小到大
top -o -MEM  # 从大到小
```

Linux:

```
top -o %MEM   # 默认从大到小
top -o +%MEM  # 从大到小
top -o -%MEM  # 从小到大
```

---

* https://www.tecmint.com/find-processes-by-memory-usage-top-batch-mode/
