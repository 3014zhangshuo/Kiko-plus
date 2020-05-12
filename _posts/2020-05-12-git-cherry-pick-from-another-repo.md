---
layout: post
title: "从其他代码库 cherry-pick commit"
date: 2020-05-12
tags: [git]
---

```
git remote add endel git://github.com/endel/rest-client.git

git fetch endel want-cherry-pick-branch

git log endel/want-cherry-pick-branch

git cherry-pick 97fedac
```

---

* https://coderwall.com/p/sgpksw/git-cherry-pick-from-another-repository
