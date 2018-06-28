---
layout: post
title: 'PG: Array Functions - array_length'
date: 2018-06-27 17:30:00
comments: true
tags: [pg]
share: false
---

dimension(维)

### Explanation

- `array_length(anyarray, int)` returns int that the length of the requested array dimension

- array_length(array[1,2,3], 1) # =>	3

### Rails Project Example

`Book.where('array_length(templates, dimension=1) = 2')`

[S](https://www.postgresql.org/docs/9.1/static/functions-array.html)
