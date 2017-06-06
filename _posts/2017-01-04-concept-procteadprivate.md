---
layout: post
title: '概念:proctead,private'
date: 2017-01-04 10:37
comments: true
categories: 
---
Ruby provides 3 ways of classifying a methods in a Class: Public, Private and Protected.  These keywords are used to declare a method’s visibility and essentially what you’re doing is restricting access to the individual methods contained in your class.

Here’s a quick and dirty about the differences:

Public

These methods are accessible by anyone who calls your class.  They define your class’s public “interface”.

Protected

Protected methods are accessible by objects of the same class.  By this definition, a good use case is when classes extend your class and want to access those methods.  The subclass will retain access into the super class’s protected methods.

Private

Private methods can mask the gory details of how the public/protected take input and generate output.  One way to look at this is that these methods are essentially for the “author of the object/class”.  And by “author” I do mean the guy who wrote the code.  Because private methods are not publicly exposed — aka someone who calls your class doesn’t have access to them — private can be considered free for refactoring, changing and deletion without worrying that your outside callers are going to have problems.

