---
layout: post
title: 'Devise:how to skip the confirmation for the new user'
date: 2017-03-08 23:30
comments: true
categories: 
---
before_create :my_method

def my_method
 self.skip_confirmation!
end

def skip_confirmation!
  self.confirmed_at = Time.now.utc
end