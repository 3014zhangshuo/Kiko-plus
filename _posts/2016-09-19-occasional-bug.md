---
layout: post
title: '偶遇bug'
date: 2016-09-19 17:28
comments: true
categories: 
---
   开始做课程的第一份作业，前几关都顺风顺水，翻墙上slack，安装开发环境....建立留言板。可到了把留言板上传到heroku时，连续出现好几个错误，瞬间感觉头大....
   
![Screen Shot 2016-09-19 at 5.42.23 PM.png](http://user-image.logdown.io/user/19380/blog/18863/post/890663/Nhvd8GEpQzkIn4JHQf4T_Screen%20Shot%202016-09-19%20at%205.42.23%20PM.png)
第一个bug，gemfile找不到....原来只是把代码输入错误的到了atom里，本来应在terminal里输入代码。
修改完了gemfile,又遇到bug了
![screen_shot_2016-09-19_at_10.30.58_am_1__720.png](http://user-image.logdown.io/user/19380/blog/18863/post/890663/2iZeSEsLTgeMy9O7wHcc_screen_shot_2016-09-19_at_10.30.58_am_1__720.png)
继续在slack上询问，这次xdite老师都出手了，原来只是修改完的gemfile没有存档（atom存档command＋s）这个错误可真蠢...
下一个错误几乎困扰了我一天，重复了数遍建立留言版到上传留言版heroku的过程
![Screen Shot 2016-09-19 at 6.07.56 PM.png](http://user-image.logdown.io/user/19380/blog/18863/post/890663/e9tBlvTa9ymtrDG0gkQx_Screen%20Shot%202016-09-19%20at%206.07.56%20PM.png)
原因是两个路径不同
解决办法输入git remote set-url heroku （heroku给你的网址）
然后在git push heroku master一次就解决了

![Screen Shot 2016-09-22 at 4.57.10 PM.png](http://user-image.logdown.io/user/19380/blog/18863/post/890663/0g3zVB7TWaZgiWw9hYcs_Screen%20Shot%202016-09-22%20at%204.57.10%20PM.png)
问题解决以后看到网页上的留言板，只能用泪奔两个字形容当时的心情.....