---
layout: post
title: "Rails create_table sql"
date: 2020-05-18
tags: [rails, sql]
---

```
CREATE TABLE `user_settings` (`id` bigint(20) auto_increment PRIMARY KEY, `company_id` bigint, `user_id` bigint, `enable_desktop_notifications` tinyint(1) DEFAULT 0, `created_at` datetime NOT NULL, `updated_at` datetime NOT NULL) ENGINE=InnoDB ROW_FORMAT=Dynamic;
```
