---
layout: post
title: '记录:bootstrap Components'
date: 2017-02-20 22:11
comments: true
categories: 
---
```
<button type="button" class="btn btn-secondary" data-container="body" data-toggle="popover" data-placement="bottom" data-content="你能够给对方公司带来什么样的价值？">
						  提示语
</button>
```

```
$(document).on("turbolinks:load", function() {
  $(function () {
    $('[data-toggle="popover"]').popover()
  });
});
```
[1](https://v4-alpha.getbootstrap.com/components/popovers/#live-demo)