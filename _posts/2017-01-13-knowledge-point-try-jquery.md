---
layout: post
title: '知识点:try jquery'
date: 2017-01-13 17:45
comments: true
categories: 
---
"DOM"document object model 
找到标签
$('h1');
更改标签的文字
$('h1').text('');
id=container $('#container');
class= container $('.container');
有时候web不会加载你的js这时候需要加入
$(document).ready(function(){});
我们选择id下面的标签
$('#destinations li'),这样就会把模块下的所有的li标签，但模块下面可能嵌套模块，我们不想要其他的模块的li标签
要$('#destinations > li');
我们还可以合并来找
$('.promo, #france');
还可以选择第一个
$('#destinations li:first');
最后一个$('#destinations li:last');
中间的$('#destinations li:odd');
还可以选择偶数个$('#destinations li:even')有时候要注意child问题

Traversing the DOM
$('#destinations li') => $('#destinations').find('li');
$('li:first') => $('li').first();

walking the dom 

$('li').first();
$('li').first().next();
$('li').first().next().prev();
$('li').first().parent();

$('#destinations').children('li');只会找直接对应的子类

$(document).ready(function(){
  $('button').on('click',funtion(){
    var price = $('<p>Form $399.99</p>');
    $('.vacation').append(price);
    $('button').remove();
  });
});


$(document).ready(function(){
  $('button').on('click', function(){
    var amount = $(this).closest('.vacation').date('price');
    var prict = $('<p>From $'+amount+'</p>')
    $(this).closest('.vacation').append(price);
    $(this).remove();
  });
});

$(document).ready(function(){
  $('button').on('click', function(){
    var vacation = $(this).closest('.vacation')
    var amount = vacation.date('price');
    var prict = $('<p>From $'+amount+'</p>')
    vacation.append(price);
    $(this).remove();
  });
});

$('.vacation button').on('click',function(){});
可以这样写，这种写法执行的效率更快
$('.vacation').on('click', 'button', function(){});

$('#filters').on('click', '.onsale-filter', function(){
  $('.vacation').filter('.onsale').addClass('highlighted');
});

$('#filters').on('click', '.expiring-filter', function(){
  $('.vacation').filter('.expiring').addClass('highlighted');
});
上面的写法会导致你切换页面的时候，原先的高亮记录会被保存
$('#filters').on('click', '.onsale-filter', function(){
  $('.highlighted').removeClass('highlighted');
  $('.vacation').filter('.onsale').addClass('highlighted');
});

$('#filters').on('click', '.expiring-filter', function(){
  $('.highlighted').removeClass('highlighted');
  $('.vacation').filter('.expiring').addClass('highlighted');
});