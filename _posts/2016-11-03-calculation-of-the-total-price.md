---
layout: post
title: '方法:购物车计算总价'
date: 2016-11-03 09:37
comments: true
categories: 
---
```
<% sum = 0 %>
<% current_user.cart_item.each do |cart_item| %>
  <% sum = sum + cart_item.quantity * cart_item.product.price %>
<% end %>
```
把Refactor放到Helper里面
<%= render_cart_total_price(current_cart) %>
```
module CartsHelper
  def render_cart_total_price(cart)
    sum = 0 
    cart.cart_items.each do |cart_item|
      sum += cart_item.quantity * cart_item.product.price 
    end
    sum
    end
  end
```
但算总价是model的任务，咱们还可以放到model里面。
把helper改成
def render_cart_total_price(cart)
  cart.total_price 
end
```
def total_price 
  sum = 0 
  cart_item.each do |cart_item|
   sum += cart_item.quantity * cart_item.product.price 
  end 
  sum
  end
end
```
  