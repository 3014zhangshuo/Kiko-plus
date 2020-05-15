---
layout: post
title: "Minitest assert_difference"
date: 2020-05-15
tags: [rails minitest]
---

之前写 `Rspec` 有很方便的方法来判断数据是否增加，增加几条：

```
expect { User.from_wx_pub!(auth) }.to change { User.count }.by(0)
```

`Minitest` 对应的方法是 `assert_difference`，用法如下：

```
assert_difference 'User.count', 1 do
  User.from_wx_pub!(auth)
end
```

---

* https://apidock.com/rails/ActiveSupport/Testing/Assertions/assert_difference
