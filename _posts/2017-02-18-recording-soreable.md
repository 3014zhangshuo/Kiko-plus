---
layout: post
title: '记录:soreable模块拖移'
date: 2017-02-18 19:49
comments: true
categories: 
---
下面代码为实现模块移动的代码
```
<div id="sortable">
		<div >Home</div>
		<div >Contact Us</div>
		<div  >FAQs</div>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
$( function() {
$( "#sortable" ).sortable({
 revert: true
});
} );
</script>
```