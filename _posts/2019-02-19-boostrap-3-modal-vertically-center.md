---
layout: post
title: "CSS: Boostrap 3 Modal Vertically Center"
date: 2019-02-19 11:39:22
comments: true
tags: [css]
share: false
---

```css
.modal {
  text-align: center;
  padding: 0!important;
}

.modal:before {
  content: '';
  display: inline-block;
  height: 100%;
  vertical-align: middle;
  margin-right: -4px;
}

.modal-dialog {
  display: inline-block;
  text-align: left;
  vertical-align: middle;
}
```

### Reference:

[Bootstrap 3 Modal Vertically Center/Max-Height](https://codepen.io/dimbslmh/full/mKfCc)
