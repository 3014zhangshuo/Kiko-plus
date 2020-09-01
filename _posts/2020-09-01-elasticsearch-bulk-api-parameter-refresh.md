---
layout: post
title: "Elasticsearch bulk API refresh 参数的作用"
date: 2020-08-28
tags: [es, elasticsearch]
---

```ruby
Elasticsearch::Model.client.bulk(body: [], refresh: true)
```

今天看到代码中批量更新索引的API中有一个参数 `refresh`，不清楚具体的作用，找了一些资料，整理如下：

首先，大概简述一下 `elasticsearch` 索引写入的流程：`写入内存（不可被检索）` -> `写入新的 segment file（可搜索，近实时性）` -> `操作系统磁盘`。

`refresh` 参数值各自作用：
* true => 目的是做到实时搜索，数据被更新的时候，触发 `refresh`，同步更新所有 shards，比较消耗性能
* wait_for => 等待 `elasticsearch` 默认触发 `refresh` (此 refresh 是 es 内部的行为，默认触发时长是 1 秒)
* false => 随缘触发 `refresh`（测试下来基本延迟不大）

---

* [elasticsearch-docs-refresh](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-refresh.html)
* [es 的 refresh 过程](https://blog.csdn.net/u011228889/article/details/80855431)
* [elasticsearch中文文档|refresh](http://doc.codingdict.com/elasticsearch/93/)
* [Elasticsearch内核解析 - 写入篇](https://zhuanlan.zhihu.com/p/34669354)
* [图解elasticsearch的写入流程(包含对refresh、fsync、flush操作的理解)](https://blog.csdn.net/R_P_J/article/details/82254494)
* [Refresh](https://aqlu.gitbooks.io/elasticsearch-reference/content/Indices_APIs/Refresh.html)
