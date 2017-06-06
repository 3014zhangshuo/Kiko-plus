---
layout: post
title: 'eatgether网站整体思路'
date: 2016-12-02 01:30
comments: true
categories: 
---
用户：1.可以发起约饭(提交一个post表单)，可以修改，删除。
     2.可以申请其他用户的约饭（需要一个申请的action，利用多对对的关系，一个用户可以有多个申请者，
                           形成一个asker_require，分别属于user和post。
                       post/model has_many: asker_users, through: :asker_require, source: :user
                       user/model has_many: ask_posts, through: :akser_require, source: :post）
       这里面有两个重点，只要user执行了application这个动作，ask_posts就会和post合并
       ```
       a = ["orange"] a << "apple" puts a result ["orange", "apple"] 
       ```
       还要判断当前用户是否为申请者，ask_posts.include?(post)
      3.用户可以通过他人申请的约饭，然后形成订单，能发送消息聊天，能确认约会，约会完成后可以填写反馈，修改反馈。
用户个人中心：兴趣爱好的单独model，也是一个多对多的关系，用到了check_boxs的知识点。
            修改个人信息的图片预览 用js来实现，关键点理解每个function的含义。
            