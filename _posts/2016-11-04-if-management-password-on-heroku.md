---
layout: post
title: '如果在heroku上管理密码'
date: 2016-11-04 20:04
comments: true
categories: 
---
很多新手小白程序员，会把自己的密钥上传到github上。这样你的内裤就被人看光光了。一旦密码上传到github上，你就等着你的aws账号被刷爆吧。。。
下面有一些保护你的隐私的方法：1.密码不要放在.rb文件里面，rb文件中写出你的密码昵称。2密码放在database.yml文件里，在.gitignore设定不要上传database.yml，github上传的时候，上传的是新建立的database.yml.example。

安装figaro(figaro是一个方便管理机密资讯，密码的gem,并且能一个指令就将机密资讯同步到heroku上)
第一步：加入gem，在终端机输入指令
```
gem “figaro”
bundle install
figaro install
```
第二步：设置机密资讯，就是复制一个空的假身。
在终端机输入`cp config/application.yml config/application.yml.example`
修改.gitignore,加入config/application.yml
第三步：将设定好的机密资讯上传到heroku上面
figaro heroku:set -e production
heroku config 可以列出目前所有的设定。
要再一次commit & push to heroku这些设定才会生效。


