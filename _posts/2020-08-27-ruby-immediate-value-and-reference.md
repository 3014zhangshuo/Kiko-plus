---
layout: post
title: "Ruby: immediate value and reference"
date: 2020-08-27
tags: [ruby]
---

#### What is the difference between an immediate value and a reference?

`Fixnum`, `true`, `nil`, and `false` are implemented as immediate value. With
immediate values, variables hold the objects themselves, rather than reference
to them.

Singleton methods cannot be defined for such objects. Two `Fixnum` of the same value always represent the same object instance, so (for example) instance variables for the `Fixnum` with the value `1` are shared between all the `1`'s in the system. This makes it impossible to define a singleton method for just one of these.

---

* https://www.ruby-lang.org/en/documentation/faq/6/
