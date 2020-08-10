---
layout: post
title: "浏览器恢复滚动行为"
date: 2020-08-08
tags: [browser, js]
---

```js
const scrollRestore = history.scrollRestoration
```

#### 查看当前页面滚动恢复行为

```js
const scrollRestoration = history.scrollRestoration
if (scrollRestoration === 'manual') {
  console.log('The location on the page is not restored, user will need to scroll manually.');
}
```

#### 自动恢复页面位置

```js
history.scrollRestoration && (history.scrollRestoration = 'auto')
```

#### 防止自动恢复页面位置

```js
if (history.scrollRestoration) {
  history.scrollRestoration = 'manual';
}
```

---

* https://developer.mozilla.org/en-US/docs/Web/API/History/scrollRestoration
