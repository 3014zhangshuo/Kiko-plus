---
layout: post
title: '3 ways to define a JavaScript class'
date: 2018-06-01 11:05:37
comments: true
tags: [JavaScript]
comments: true
share: true
---
### 1. Using a function

```
function Apple (type) {
    this.type = type;
    this.color = 'red';
    this.getInfo = getAppleInfo;
}

function getAppleInfo() {
    return `${this.color} ${this.type} apple`
}

=> var apple = new Apple('macintosh');
=> apple.color = "reddish";
=> console.log(apple.getInfo());
```
上面定义apple的getInfo是调用一个单独的方式，该方法暴露在`global namespece`，这样会有方法名称冲突的风险，用下面的方法进行改良。
```
# Method defined internally

function Apple (type) {
    this.type = type;
    this.color = "red";
    this.getInfo = function() {
        return this.color + ' ' + this.type + ' apple';
    };
}

# Methods added to the prototype

Apple.prototype.getInfo = function() {
    return this.color + ' ' + this.type + ' apple';
};
# old or new same work
```
### 2. Using object literals

```
var o = {}; instead of var o = new Object();
var a = []; instead of var a = new Array();

var apple = {
    type: "macintosh",
    color: "red",
    getInfo: function () {
        return this.color + ' ' + this.type + ' apple';
    }
}
```

### 3. Singleton using a function
> Singleton : such as Java, singleton means that you can have only one single instance of this class at any time, you cannot create more objects of the same class.
In JavaScript (no classes, remember?) this concept makes no sense anymore since all objects are singletons to begin with.

```
var apple = new function() {
    this.type = "macintosh";
    this.color = "red";
    this.getInfo = function () {
        return this.color + ' ' + this.type + ' apple';
    };
}
```
[转自于](https://www.phpied.com/3-ways-to-define-a-javascript-class/)
