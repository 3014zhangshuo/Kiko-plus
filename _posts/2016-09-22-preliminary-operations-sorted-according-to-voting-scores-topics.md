---
layout: post
title: '初级作业－根据投票分数排序 topics'
date: 2016-09-22 14:40
comments: true
categories: 
---
在app／controllers／topics_controller.rb加一个def
像这样
def index
@topics = Topic.all.sort_by { |vote| vote.votes.count }.reverse
end