---
layout: post
title: 'Javascript: language syntax'
date: 2018-06-30 9:30:00
comments: true
tags: [rails]
share: false
---

### Arrow function

#### Common Syntax
```
(参数1, 参数2, …, 参数N) => { 函数声明 }
//var test = (a, b) => { a+b }  #=> test(1,2) => undefined no return 3 must add return key word
(参数1, 参数2, …, 参数N) => 表达式（单一）
//var test = (a, b) => a+b  #=> test(1,2) => 3
//相当于：(参数1, 参数2, …, 参数N) =>{ return 表达式; }

// 当只有一个参数时，圆括号是可选的：
(单一参数) => {函数声明}
//var test = (a) => { a } #=> test(3) => undefined
单一参数 => {函数声明}
//var test = a => { a } #=> test(3) => undefined

// 没有参数的函数应该写成一对圆括号。
() => {函数声明}
//var test = () => { return 'hello world' } #=> test() => "hello world"
```

#### Advance Feature
```
# Parenthesize the body of function to return an object literal expression
params => ({foo: bar})
var object = { a: 1, b: 2 }
var test = params => ({key: object})
test(object) # => {key: { a: 1, b: 2 }}

# accept rest arguments
(param1, param2, ...rest) => { statements }
var test = (param1, ...args) => { return param1 + args[0] + args[1] }
test(1, 2, 3)

# default arguments
(param1=defaultValue1, param2) => { statements }
var test = (a="you name is ", name) => { return a + name }
test(undefined, "zhangshuo") # => "you name is zhangshuo"

# Destructuring within the parameter list
var f = ([a, b] = [1, 2], {x: c} = {x: a + b}) => a + b + c;
f() # => 6
```

#### Shorter functions
```
var elements = [
  'Hydrogen',
  'Helium',
  'Lithium',
  'Beryllium'
];

elements.map(function(element) {
  return element.length;
}); // [8, 6, 7, 9]

elements.map((element) => {
  return element.length;
}); // [8, 6, 7, 9]

elements.map(element => element.length)
// [8, 6, 7, 9]

elements.map(({length}) => length)
// [8, 6, 7, 9]
```

#### This

```
function Person() {
  // The Person() constructor defines `this` as an instance of itself.
  this.age = 0

  setInterval(function growUp() {
    // In non-strict mode, the growUp() function defines `this`
    // as the global object (because it's where growUp() is executed.),
    // which is different from the `this`
    // defined by the Person() constructor.
    this.age++
  }, 1000)
}

# fix assigning the value in this to a variable that
function Person() {
  var that = this;
  that.age = 0;

  setInterval(function growUp() {
    // The callback refers to the `that` variable of which
    // the value is the expected object.
    that.age++;
  }, 1000);
}

# An arrow function does not have its own this; the this value of the enclosing execution context is used.
function Person() {
  this.age = 0;

  setInterval(() => {
    // |this| properly refers to the Person object
    this.age++;
  }, 1000);
}

var p = new Person();

# strict mode
var f = () => { 'use strict'; return this; };
f() === window // true
```

#### Invoked through call or apply
Since arrow functions do not have their own this, the methods `call()` or `apply()` can only pass in parameters. `thisArg` is ignored.
```
var adder = {
  base: 1,

  add: function(a) {
    var f = v => v + this.base;
    return f(a);
  },

  addThruCall: function(a) {
    var f = v => v + this.base;
    var b = {
      base: 2
    };

    return f.call(b, a);
  }
};

console.log(adder.add(1));         // This would log to 2
console.log(adder.addThruCall(1)); // This would log to 2 still
```

#### No binding of arguments
Arrow functions do not have their own `arguments` object. Thus, in this example, arguments is simply a reference to the arguments of the enclosing scope:
```
var arguments = [1, 2, 3];
var arr = () => arguments[0];

arr(); // 1

var arr = function(){ return arguments[0] }
arr(9); // 9
function foo(n) {
  var f = () => arguments[0] + n; // foo's implicit arguments binding. arguments[0] is n
  return f();
}

foo(1); // 2
```

```
sendMessage(argu1, argu2)

function sendMessage(name, message) {
  console.log(arguments.length)
  if (arguments.length < 2) {
    throw new Error('missing arguments')
  }
  return(name + ' ' + message)
}

var sendMessage = (name, message) => {
  console.log(arguments.length)
  if (arguments.length < 2) {
    throw new Error('missing arguments')
  }
  return(name + ' ' + message)
}
```
