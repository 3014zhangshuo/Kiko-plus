---
layout: post
title: "Rails: Set env variable without use gem"
date: 2019-01-26 11:39:22
comments: true
tags: [rails ruby]
share: false
---

### Add env file
Create a file `config/local_env.yml`:
```yml
# Rename this file to local_env.yml
# Add account settings and API keys here.
# This file should be listed in .gitignore to keep your settings secret!
# Each entry gets set as a local environment variable.
# This file overrides ENV variables in the Unix shell.
# For example, setting:
# GMAIL_USERNAME: 'Your_Gmail_Username'
# makes 'Your_Gmail_Username' available as ENV["GMAIL_USERNAME"]
GMAIL_USERNAME: 'Your_Gmail_Username'
```
### Set .gitignore
```
/config/local_env.yml
```
### Rails Application Configuration File

```ruby
config.before_configuration do
  env_file = File.join(Rails.root, 'config', 'local_env.yml')

  YAML.load(env_file).each do |evn_name, evn_value|
    ENV[evn_name.to_s] = evn_value
  end if File.exists?(env_file)
end
```

### Reference:
[Rails Environment Variables](http://railsapps.github.io/rails-environment-variables.html)
