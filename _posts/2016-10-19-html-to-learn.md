---
layout: post
title: 'html自学'
date: 2016-10-19 08:24
comments: true
categories: 
---
HTML大多的元素被定义为块级元素`<div>`和内联元素`<span>`。
块级元素在浏览器显示时都以新行开始和（结束），而内联元素则不这样。
`<div>`是块级元素，是包含其他HTML元素的一个容器，没有特定的含义，用于对大的内容块设置样式属性。
`<span>`是内联元素，可用作文本的容器，也没有特定的含义，用于部分文本设置样式属性。
`<p>``<br>`的不同：`<p>`是用来定义段落的，`<br>`是用来换行的。
`<br>`是一个空的HTML元素。
`id`／`class`：在一个页面内`id`规定了特定的名称，`class`规定了一类的名称。id的优先级高于class。

如何使用 table 排版
用table来定义表格，算是用来装载表格内容的一个容器。
表格有若干行，用`<tr>`

元素来定义。
每行被分割为若干的单元格，用`<td>`元素来定义。
```
<table>
<tr>
<td>row 1, cell 1</td>
<td>row 1, cell 2</td>
</tr>
<tr>
<td>row 2, cell 1</td>
<td>row 2, cell 2</td>
</tr>
</table>
```
在阅览器显示是这样的
```
row 1, cell 1	row 1, cell 2
row 2, cell 1	row 2, cell 2
```
可以在`<table>`里面来定义边框的属性，像这样`<table border="1">`。
表格的表头可以使用`<th>`元素来定义,像这样`<th>Heading</th>`。
要想使一个单元格为空，不可以这样`<td></td>`，因为这样显示不出来表格的边框，正确的写法是这样`<td>&nbsp;</td>`