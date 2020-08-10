---
layout: post
title: "Minitest request 指定 Content-Type 为 json"
date: 2020-05-14
tags: [rails, ruby]
---

```
get :show, format: :json

post :create, { format: :json, { data: data } }
put :update, { format: :json, { data: data } }
```

---

* https://stackoverflow.com/questions/5841093/how-to-post-json-data-in-rails-3-functional-test/15160002#15160002
