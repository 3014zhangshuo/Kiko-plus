---
layout: post
title: '方法:购物车练习作业详解'
date: 2016-11-04 13:18
comments: true
categories: 
---
1.请设计一个功能，可以一键清空购物车
在carts_controller里面加一个action
```
def destroy 
  @cart = current_cart 
  @cart.destroy 
  redirect_to :back
end
```
下面重点来了，在路由里面使用collection的方法
```
resources :carts do 
  collection do 
  delete :destroy
  end
end
```
记得要在view里添加method。
2.某样东西突然不想买了，我可以再购物车内删除它
在cart_item的controller里面加入正常的destroy的action就行了
```
def destroy 
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy 
  redirect_to :back 
 end
```
3.已经加入购物车的物品，不能被重复加入
在product_controller里面的加入购物车的action中加入一个判断式
current_cart.products.include?(@product)
4.可以更改购物车内购买的数量
其实就是加一个button的按钮，让商品的数量进行加1
在cart_item controller里面加一个action，我们叫它add_cart_item
```
@cart_item = CartItem.find(params[:id])
@cart_item.quantity += 1 
@cart_item.save 
```
同时我们还可以做一个减1的功能
```
@cart_item = CartItem.find(params[:id])
@cart_item.quantity -= 1 
@cart_item.save 
```
5.库存的数量为0的时候，我们应该不能再减少了，我们需要在减的action里面加入一个判断式
if @cart_item.quantity < 1 
如果它的数量小于1的时候我们不执行什么动作，但也可以给出flash
6.在购物车新增数量时，不能更新超过原有库存的数量，同样要加一个判断式，这里我们要比较购物车条目的数量和商品的数量
（购物车一个条目对应一个商品）
if @cart_item.quantity < @cart_item.product.quantity

