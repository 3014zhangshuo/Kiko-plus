---
layout: post
title: "Rails 转化输入为 boolean 值"
date: 2020-05-14
tags: [rails]
---

总会有这个时候，需要在 controller 里面这么做：

```
params[:active] == 'true'
```

这样写测试的时候就麻烦了：

```
post :create, { active: true }
```

这里 params active 到 controller 就是 true 不是 'true'，难道还要这么做：


```
params[:active] == 'true' || params[:active] == true
```

** WTF!!! **

好在 Rails 提供了转换的方法，看方法名是用来处理这种场景的：

```
TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set
FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF'].to_set
```

In Rails 4.2

```
ActiveRecord::Type::Boolean.new.type_cast_from_user(value)
```

In Rails 5

```
ActiveModel::Type::Boolean.new.cast(value)
```

---

* https://stackoverflow.com/questions/36228873/ruby-how-to-convert-a-string-to-boolean/44322375#44322375
