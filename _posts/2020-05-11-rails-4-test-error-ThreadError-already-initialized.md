---
layout: post
title: "修复 Minitest ThreadError: already initialized"
date: 2020-05-11
tags: [rails]
---

错误原因仅发生在 `Rails` 版本低于 `5`，`Ruby` 版本高于 `2.6.0`

解决办法：

```
if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end
```

---

* https://github.com/rails/rails/issues/34790
