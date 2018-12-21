---
layout: post
title: 'Linux: How To Delete All Files Except Last'
date: 2018-12-20 11:39:22
comments: true
tags: [linux]
share: false
---

### Result:

```shell
ls -t1 /var/path/to/folder | tail -n +2 | xargs rm -r
```

* `ls -t1` is printing a list, one file/directory per line, of all files in /var/path/to/folder, ordering by the most recent modification date.

* `tail -n +2` is printing all lines in the output of ls -t1 starting with the fourth line (i.e. the three most recently modified files won't be listed)

* `xargs rm -r` says to delete any file output from the tail. The -r means to recursively delete files, so if it encounters a directory, it will delete everything in that directory, then delete the directory itself.

### Reference:
[how-to-delete-all-files-except-the-latest-three-in-a-folder](https://stackoverflow.com/questions/4447326/how-to-delete-all-files-except-the-latest-three-in-a-folder)
