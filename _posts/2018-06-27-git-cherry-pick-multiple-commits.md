---
layout: post
title: 'Git cherry-pick Multiple Commits'
date: 2018-06-27 17:00:00
comments: true
tags: [git]
share: false
---
`cherry-pick A_commit_code..B_commit_code`

Note:

* A should be older than B.
* not cherry-pick A, but rather everything after A up to and including B.
* To include A just type `git cherry-pick A_commit_code^..B_commit_code`

[S](https://stackoverflow.com/questions/1670970/how-to-cherry-pick-multiple-commits)
