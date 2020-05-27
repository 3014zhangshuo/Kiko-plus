---
layout: post
title: "Rails Minitest: Mock controller method"
date: 2020-05-26
tags: [rails minitest]
---

```ruby
setup do
  @controller.stubs(:doorkeeper_token).returns(token)
end
```

```ruby
require 'minitest/autorun'

book = MiniTest::Mock.new
# Set the mock to expect :title, return "War and Piece"
# (note that unless we call book.verify, minitest will
# not check that :title was called)
book.expect :title, "War and Piece"

# Stub Book.new to return the mock object
# (only within the scope of the block)
Book.stub :new, book do
  wp = Book.new # returns the mock object
  wp.title      # => "War and Piece"
end
```

---

* https://semaphoreci.com/community/tutorials/mocking-in-ruby-with-minitest
* https://stackoverflow.com/questions/26681087/stub-any-instance-using-minitest?rq=1
* https://github.com/codeodor/minitest-stub_any_instance
* https://coderwall.com/p/rgpiaq/stub-any-instance-with-minitest