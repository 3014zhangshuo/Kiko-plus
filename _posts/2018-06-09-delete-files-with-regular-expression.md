---
layout: post
title: 'Delete files with regular expression'
date: 2018-06-09 11:05:37
comments: true
tags: [Shell]
comments: true
share: true
---

> ls | grep -P "your regex code" | xargs -d"\n" rm

* xargs -d"\n" rm executes rm line once for every line that is piped to it.


[S1](https://superuser.com/questions/392872/delete-files-with-regular-expression/1144476)
