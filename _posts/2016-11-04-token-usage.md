---
layout: post
title: '方法：token的使用方法'
date: 2016-11-04 13:10
comments: true
categories: 
---
####比如要把order后面的流水单号加密，我们需要在order里面加入一个栏位

#####rails g migration add_token_to_order
```
def change 
  add_column :orders, :token, :string 
  add_index :orders, :token 
end
```
#####每一笔订单产生前，先乱数产生token

#####在model层里面进行添加
```
before_create :generate_token 

def generate_token 
  self.token = SecureRandom.uuid 
end
```
#####设置导向新网址
```
@order = Order.find_by_token(params[:id])
redirect_to order_path(@order.token)
```