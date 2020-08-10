---
layout: post
title: "转换文件的编码格式，从：ISO-8859-1 到：UTF-8"
date: 2020-04-27
tags: [linux]
---

```
iconv -f ISO-8859-1 -t UTF-8 in.txt > out.txt
```

---

* https://stackoverflow.com/questions/64860/best-way-to-convert-text-files-between-character-sets
