---
layout: post
title: "探究 ActiveSupport test 方法"
date: 2020-05-11
tags: [rails]
---

想在 `test` 中把测试的名字作为参数进行引用，省着重复书写变量，像这样：

```
test "0" do
  assert support?("0")
end
```

以为可以这样做：

```
test "0" do
  assert support?(__method__)
end
```

但查看源码，发现 `test_name` 被处理过了，都加上了前缀 `test_`。

```
# File activesupport/lib/active_support/testing/declarative.rb
def test(name, &block)
  test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
  defined = method_defined? test_name
  raise "#{test_name} is already defined in #{self}" if defined
  if block_given?
    define_method(test_name, &block)
  else
    define_method(test_name) do
      flunk "No implementation provided for #{name}"
    end
  end
end
```
