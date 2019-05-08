---
layout: post
title: "HTML中a标签如何实现post请求的"
date: 2019-05-05
comments: true
tags: [原理]
share: true
---
今天查看rails是如何为`link_to`中post请求加上`authenticity_token`才发现a链接不是天然就支持post请求的,
是需要经过代码处理才可以。下面列出2种实现方式，rails使用的是创建表单的方式。

#### 创建表单方式
```html
<a href="javascript:doPost("addStudent.action", {"name":"张三"})">提交</a>
```

```js
function doPost(action, params) {
  const postForm = document.createElement("form")
  postForm.method = "post"
  postForm.action = action
  // set params
  for (var i in params) {
    var input = document.createElement("input")
    input.setAttribute("name", i)
    input.setAttribute("value", params[i])
    postForm.appendChild(input)
  }
  // create real form and submit
  document.body.appendChild(postForm)
  postForm.submit()
  // remove post form
  document.body.removeChild(postForm)
}
```

#### 使用ajax的方式（比较常用）
```html
<a href="addStudent.action" class="a_post">提交</a>
```

```js
$(".a_post").on("click",function(event){
  event.preventDefault()
  const a = $(event.currentTarget)
  $.ajax({
      type: "POST",
      url: a.attr("href")
      data: JSON.stringify({param1:value1, param2:value2}),
      dataType:"json",
      success: function(result){},
      error: function(result){}
  })
})
```

#### Rails 是如何实现的
```ruby
link_to "This is post link", post_url, method: :post
# <a href="/post" data-method="post" rel="nofollow"><This is post link</a>
```

```coffee
Rails.handleMethod = (e) ->
  link = this
  method = this.getAttribute("data-method")
  return unless method

  href = Rails.herf(link)
  csrfToken = Rails.csrfToken()
  csrfParam = Rails.csrfParam()
  form = document.createElement("form")
  formContent = "<input name='_method' value=#{method} type='hidden' />"

  if csrfParam? and csrfToken? and not Rails.isCrossDomain(href)
    formConent += "<input name='#{csrfParam}' value='#{csrfToken}' type='hidden' />

  formContent += "<input type='submit' />"

  form.method = 'post'
  form.action = href
  form.target = link.target
  form.innerHTML = formContent
  form.style.display = 'none'

  document.body.appendChild(form)
  form.querySelector('[type="submit"]').click()
```

rails为请求加入了`_method`参数，是用来内部实现`RESTful`设计的。

#### 参考
* [怎样使用a标签以post方式提交]("https://blog.csdn.net/LZGS_4/article/details/43156133")
* [Rails-ujs](https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs)



