---
layout: post
title: '方法:Mac OS X中显示/不显示隐藏文件方法 命令行'
date: 2016-11-04 10:25
comments: true
categories: 
---
在终端中执行如下代码并重启动Finder。
显示隐藏文件：
defaults write com.apple.finder AppleShowAllFiles -bool TRUE
停止显示隐藏文件：
defaults write com.apple.finder AppleShowAllFiles -bool FALSE
 
注：重启Finder的方法：
按住option+command，dock上右键->“Relanch”/“重新开启”。