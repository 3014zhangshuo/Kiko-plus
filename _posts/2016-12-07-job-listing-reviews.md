---
layout: post
title: 'job-listing回顾'
date: 2016-12-07 00:23
comments: true
categories: 
---
1.首页分别可以按薪资上限、薪资下限和时间来进行排序。
controller写法
```
def index 
  @jobs = case params[:order]
          when 'by_upper_bound'
          Job.publish.order( 'wage_upper_bound DESC' )
          when 'by_lower_bound'
          Job.publish.order( 'wage_lower_bound DESC' )
          else 
          Job.publish.order( created_at DESC )
 end
```
view里面这么写
```
<%= link_to("按照上限排序", jobs_path(:order => by_upper_bound) ) %>
<%= link_to("按照下限排序", jobs_path(:order => by_lower_bound) ) %>
```
  