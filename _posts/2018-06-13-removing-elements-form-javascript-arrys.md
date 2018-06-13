---
layout: post
title: 'Removing elements form javascript arrays'
date: 2018-06-13 00:00:00
comments: true
tags: [javascript]
share: false
---
#### Method.1 indexOf() and splice()
* v1
  ```
  function remove(array, element) {
      const index = array.indexOf(element);
      array.splice(index, 1);
  }
  ```
  The v1 has bug, if element is a not exist value in array, the indexOf method will be retrun -1, -1 is a negative index，which represents the last element in the array
* fix v1
  ```
  function remove(array, element) {
      const index = array.indexOf(element);

      if (index !== -1) {
          array.splice(index, 1);
      }
  }
  ```
#### Method.2 filter()   
```
function remove(array, element) {
    return array.filter(e => e !== element);
}
```
[S](https://blog.mariusschulz.com/2016/07/16/removing-elements-from-javascript-arrays)
