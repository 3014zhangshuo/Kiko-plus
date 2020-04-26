---
layout: post
title: "Elasticsearch 安装、基本用法、概念"
date: 2020-04-26
tags: [elasticsearch]
---

## 安装与启动

### 在 Mac 上用 homebrew 安装 elasticsearch

```
brew install elasticsearch

elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.3.0/elasticsearch-analysis-ik-6.3.0.zip # 安装分词插件
```

### 设定配置文件

覆盖默认的配置文件，mac 上默认的配置文件目录是 `/usr/local/etc/elasticsearch`。

```
cp /YOUR_CONF_PATH/config/elasticsearch/settings.yml /usr/local/etc/elasticsearch/elasticsearch.yml

export ES_PATH_CONF=/usr/local/etc/elasticsearch # 设定配置文件目录
```

### 运行

```
elasticsearch # 如果不是通过homebrew安装的，应该是在安装目录下执行 ./bin/elasticsearch
```

## 语法

`must`的两个条件都必须满足，`should`中的两个条件至少满足一个就可以。如果想满足多个`should`条件，可以设定`minimum_should_match = 满足条件数`。

```
{
  "bool": {
    "should": [
      { "term": { "title": "brown" }},
      { "term": { "title": "fox"   }},
      { "term": { "title": "quick" }}
    ],
    "minimum_should_match": 2
  }
}
```

---

* https://blog.csdn.net/wyqwilliam/article/details/84024182
* https://www.elastic.co/guide/cn/elasticsearch/guide/current/_how_match_uses_bool.html
