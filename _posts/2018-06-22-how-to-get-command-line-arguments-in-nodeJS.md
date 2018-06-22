---
layout: post
title: 'How do I pass command line arguments to a Node.js program?'
date: 2018-06-22 00:00:00
comments: true
tags: [NodeJS]
share: false
---
The arguments are stored in `process.argv`

`process.argv` is an array containing the command line arguments. The first element will be 'node', the second element will be the name of the JavaScript file. The next elements will be any additional command line arguments.

[S1](https://stackoverflow.com/questions/4351521/how-do-i-pass-command-line-arguments-to-a-node-js-program)

[S2](https://nodejs.org/docs/latest/api/process.html#process_process_argv)
