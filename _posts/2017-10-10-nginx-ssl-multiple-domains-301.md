---
layout: post
title: 'Nginx https multiple domains 301 redirect'
date: 2017-10-10 21:32
comments: true
tags: [nginx]
comments: true
share: true
---

* 网站拥有多个domain，但需要统一跳转到一个
* 需要重定向 443 端口
解法：

```
server {
    listen         *:443 ssl;
    server_name   domain1.com;
    ssl_certificate /path/to/domain1.crt; 
    ssl_certificate_key /path/to/domain1.key;
    return         301 https://www.domain1.com$request_uri;
}

server {
    listen         *:443 ssl;
    server_name   domain2.com www.domain2.com;
    ssl_certificate /path/to/domain2.crt; 
    ssl_certificate_key /path/to/domain2.key;
    return         301 https://www.domain1.com$request_uri;
}

server {
    listen         *:443 ssl;
    server_name   domain3.com www.domain3.com;
    ssl_certificate /path/to/domain3.crt; 
    ssl_certificate_key /path/to/domain3.key;
    return         301 https://www.domain1.com$request_uri;
}
```

[原文](https://www.digitalocean.com/community/questions/nginx-ssl-multiple-domains)