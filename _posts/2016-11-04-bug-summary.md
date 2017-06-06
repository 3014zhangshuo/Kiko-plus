---
layout: post
title: '问题:if判断出现的问题'
date: 2016-11-04 12:07
comments: true
categories: 
---
if只能判断Boolean值，也就是true和false，例如用状态机定义order的状态时（aasm-state），order的状态变量是个string值，if不能直接加.点来进行判断。正确的写法是这样`< if order.aasm_state == "paid" >`

rails c上的一些用法CartItem.destroy_all

安装gem ‘pry’ ，用binding.pry来进行debug

在job-listing里面让user/admin切换状态的时候，如果判断式为`< if user.is_admin = true >`就不会更改状态

html class = ""
ruby class: "" 	
