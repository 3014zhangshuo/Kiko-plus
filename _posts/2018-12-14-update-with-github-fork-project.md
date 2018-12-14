---
layout: post
title: 'Git: Syncing a fork'
date: 2018-12-14 11:39:22
comments: true
tags: [git]
share: false
---

### Configuring remote upstream
```shell
$ git remote add upstream https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git
```
### Syncing
#### fetch remote upstream updated
```shell
$ git fetch upstream
```
#### check to your want to merged branch
```shell
$ git checkout master
```
#### merged it
```shell
$ git merge upstream/master
```

### Reference:
* [Configuring a remote for a fork](https://help.github.com/articles/configuring-a-remote-for-a-fork/)
* [Syncing a fork](https://help.github.com/articles/syncing-a-fork/)
