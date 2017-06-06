---
layout: post
title: '记录:whenever cap deploy config'
date: 2017-03-03 11:41
comments: true
categories: 
---
```
    set :whenever_roles,        ->{ [:db, :app, :web] } 这里三个全部要加入
    set :whenever_command,      ->{ [:bundle, :exec, :whenever] }
    set :whenever_command_environment_variables, ->{ { rails_env: fetch(:whenever_environment) } }
    set :whenever_identifier,   ->{ fetch :application }
    set :whenever_environment,  ->{ fetch :rails_env, fetch(:stage, "production") }
    set :whenever_variables,    ->{ "environment=#{fetch :whenever_environment}" }
    set :whenever_update_flags, ->{ "--update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}" }
    set :whenever_clear_flags,  ->{ "--clear-crontab #{fetch :whenever_identifier}" }
```