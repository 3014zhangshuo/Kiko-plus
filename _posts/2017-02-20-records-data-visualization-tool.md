---
layout: post
title: '记录:数据可视化工具'
date: 2017-02-20 21:04
comments: true
categories: 
---
[github](https://github.com/ankane/chartkick)
[office](http://chartkick.com/)
在添加反馈功能可以向用户索要反馈，为了让后台的数据看起来更清晰，在后台里面添加了数据可视化的功能。
上面是github地址和官网说明。
安装完gem后在application.js加入这个gem的js。
```
//= require Chart.bundle
//= require chartkick
```
这里我用了两个图标柱形图和圆形图
```
  <h4>万能简历反馈填写</h4>
<%= bar_chart resume_white_step_1: @feedbacks.where(:step => "resume_white_step_1").count,
resume_white_step_2: @feedbacks.where(:step => "resume_white_step_2").count,
resume_white_step_3: @feedbacks.where(:step => "resume_white_step_3").count,
resume_white_step_4: @feedbacks.where(:step => "resume_white_step_4").count,
resume_white_step_5: @feedbacks.where(:step => "resume_white_step_5").count %>
```
```
    <h4>黑客简历步骤二打分情况<h4>
    <%= pie_chart "一般般": @feedbacks.where(:step => "resume_hack_step_2").where(:score => 2).count,
    "糟糕": @feedbacks.where(:step => "resume_hack_step_2").where(:score => 1).count,
    "非常好": @feedbacks.where(:step => "resume_hack_step_2").where(:score => 3).count%>
   </div>
```
这里要注意不能直接引用model我之前写`Feedback.where(:step => "resume_hack_step_2")`这样是不work的(报错是no template)，这里必须要用带@的变量