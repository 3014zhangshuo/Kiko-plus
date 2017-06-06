---
layout: post
title: '问题:简历专案上传heroku时，css和js not loading'
date: 2016-12-25 02:07
comments: true
categories: 
---
在简历专案部署上heroku的时候，css和js都没有加载出来。导致页面排版和按钮基本全废。
css的问题比较好看出来，因为页面是乱的。但是js的问题，导致我以为是编码出现了问题，而且在本地运行还是ok的。fuck。。
好在有学霸的提醒，利用chrome查出来是js完全就没有加载。fuck。。google搜了一下，可能是css和js都没有被git进远端仓库里面，需要把远端对应的文件删除掉，然后重新上传一份。
还有一种方法在config/application.rb里面设置config.assets.initialize_on_precompile = false，在config/initializers/assets.rb里面设置Rails.application.config.assets.precompile += %w( *.scss *.js )。
然后重新跑
```
rake assets:precompile RAILS_ENV=production
git add .
git commit -a -m "JS"
git push heroku master
```
有时候需要前面和后面的办法一切才能够解决问题。
解决办法:
[js](http://stackoverflow.com/questions/28923323/heroku-updated-javascript-and-css-not-loading)
[css](http://stackoverflow.com/questions/9056684/css-is-looking-different-on-heroku)
[another](http://stackoverflow.com/questions/33749149/javascript-function-not-load-on-heroku?rq=1)