---
layout: post
title: 'Ubuntu VM Run Npm Script No Hang Up'
date: 2018-06-26 15:00:00
comments: true
tags: [CSS]
share: false
---
`forever start -c "npm run ts-node" /home/apps/file-wechaty/file.ts` throw `npm ERR! path /home/user/package.json`



fix: `forever start -c "npm --prefix ./file-wechaty run ts-node" /home/apps/file-wechaty/file.ts`

- -c meaning command
- `forever list` list of running script
- `forever stop PID` stop script
- `forever restart PID` restart script


[NPM_PATH](https://stackoverflow.com/questions/37078968/how-to-specify-the-path-of-package-json-to-npm)
