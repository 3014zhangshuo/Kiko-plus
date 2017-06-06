---
layout: post
title: '知识点:simple_format 和 simple_form_for'
date: 2016-10-25 11:07
comments: true
categories: 
---
这里是第一行\r\n（`<br>`）这里是第二行 simple_format是让html里面ruby语言自动断行。
simple_form_for是表单的意思

http://localhost:3000/jobs/1
这里的id是1
http://localhost:3000/jobs/2/resumes/3
这里的id是3，2是job_id

new
<%= form_for @job do |f| %>
<%= form_for @job :url => jobs_path, :method => :post %>

edit
<%= form_for @job do |f| %>
<%= form_for @job :url => jobs_path(@job), :method => :post %>

<%= form_for[:admin,@job] do |f| %>
<%= form_for @job, :url => admin_jobs_path, :method => :post %>
`:admin`对应的是namespace

<%= form_for[@job,@resume] do |f| %>
<%= form_for @job, :url => job_resume_path, :method => :post %>
`@job,@resume`是双层resource

路由要分好关系