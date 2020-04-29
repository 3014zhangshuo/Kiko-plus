---
layout: post
title: "Elasticsearch 深度分页（deep pagination）"
date: 2020-04-28
tags: [elasticsearch]
---

如果用 `Elasticsearch` 分页的话返回的结果数据集不能超过 `1w` 条，为了防止深度分页急剧地消耗
`CPU`、`内存`、`带宽`。

`Elasticseach` 类似于一个分布式文档型数据库，假设我们的一个 `index`（概念上类似于关系型数据库上的table）
有五个 `shard`（节点），如果你想读取1000到1010之间的10条数据，`Elasticsearch` 其实会在每个节点上都读取
1010条数据，最后把所有节点读取的数据汇总到协调节点上（coordinator node），然后再进行排序去头10条数据返回。

`Elasticseach` 提供了两种方法来解决深度分页：

#### Scroll Api

实现原理：通过一次查询后维护一个索引快照的 search content，然后每次批量的读取数据。

缺点：维护一个 search content 需要占用很多资源，而且在快照建立后数据的删除和更新都不会感知到，
所以不能够用于实时和高并发的场景。

用法：

```
result = client.search index: 'scrollindex',
                       scroll: '5m',
                       body: { query: { match: { title: 'test' } }, sort: '_id' }

result = client.scroll scroll: '5m', scroll_id: result['_scroll_id']
```

#### SearchAfter Api

实现原理：通过维护一个实时游标来避免 Scroll Api 的缺点，它可以用于实时请求和高并发场景。

缺点：
* 不能随机跳转分页，只能一页一页地向后翻，并且需要指定一个唯一不重复字段来排序。
* 相比于 Scroll Api 读取数据的顺序会受索引的更新和删除的影响。

用法：

```
# 第一个请求
GET twitter/_search
{
    "size": 10,
    "query": {
        "match" : {
            "title" : "elasticsearch"
        }
    },
    "sort": [
        {"date": "asc"},
        {"_id": "desc"}
    ]
}

# 第二个请求
GET twitter/_search
{
    "size": 10,
    "query": {
        "match" : {
            "title" : "elasticsearch"
        }
    },
    "search_after": [1463538857, "654323"], # 来自第一个请求返回的 data 和 id
    "sort": [
        {"date": "asc"},
        {"_id": "desc"}
    ]
}
```

---

* http://www.321332211.com/thread?topicId=139
* http://doc.codingdict.com/elasticsearch/117/
* http://www.piaoyi.org/database/Elasticsearch-Search_After.html
* http://www.piaoyi.org/database/Elasticsearch-from-size-scroll.html
* https://github.com/elastic/elasticsearch-ruby/blob/18d3dc331e1564acc5b69799c4a2add6676d8321/elasticsearch-api/lib/elasticsearch/api/actions/scroll.rb

