---
layout: post
title: '问题:某括号内的内容是什么意思？'
date: 2016-10-25 07:02
comments: true
categories: 
---
<%= link_to(job.title, admin_job_path(job)) %>
admin_job_path(job)这个（job）是什么意思？

admin_job_path(job)等价于admin_job_path(job.id)
会连接到/admin/jobs/1