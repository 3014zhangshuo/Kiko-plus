---
layout: post
title: '问题:show的id方面'
date: 2016-12-11 00:09
comments: true
categories: 
---
#####1.首先建立了一个about页面。例子为topics/about.html.erb
 get 'topics/about' => 'topics#about'这样action会找def show 
 get 'about/topics' => 'topics#about'这样就会work 
 
 #####默认去找id=about的页面.
 
 方法一

config/routes.rb
  resources :topics do
+   collection do
+     get 'about'    
+   end
    member do
      post 'upvote'
      post 'downvote'
    end
  end
app/controllers/topics_controller.rb
+ def about
+ end
touch app/views/topics/about.html.erb

app/views/topics/about.html.erb
+ <h1>About</h1>
+ <%= link_to 'Back', root_path %>
方法二

rails g controller about index

app/views/topics/index.html.erb
+ <%= link_to 'About', about_index_path %>
app/views/about/index.html.erb
+ <%= link_to 'Back', topics_path %>

