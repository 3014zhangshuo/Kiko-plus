---
layout: post
title: 'Node: Use ES6 Import in Node'
date: 2018-12-19 11:39:22
comments: true
tags: [node]
share: false
---

### Prue
* Save the file with ES6 modules with `.mjs` extension.
* Run command `node --experimental-modules index.mjs`

### Babel
#### Install babel-cli and babel-preset-env
`$ npm install --save-dev babel-cli babel-preset-env`
#### Create a .babelrc file for configuring babel.
`$ touch .babelrc`
#### Add config in .babelrc
```json
{
  "presets": ["env"]
}
```
#### Add build script, in package.json
```json
"scripts": {
  "build": "babel index.js -d dist"
}
```
#### Add start script, in package.json
```json
"scripts": {
  "build": "babel index.js -d dist",
    "start": "npm run build && node dist/index.js"
}
```
#### Run script
`npm start`

#### ReferenceError: Unknown plugin "transform-runtime"
`npm install babel-plugin-transform-runtime --save-dev`
```js
// .babelrc

{
  "presets": ["env"],
+ "plugins": [
+   "transform-runtime"
+ ]
}

```

### Reference:
* [how-can-i-use-an-es6-import-in-node](https://stackoverflow.com/questions/45854169/how-can-i-use-an-es6-import-in-node)
* [use-es6-javascript-syntax-require-import](https://hackernoon.com/use-es6-javascript-syntax-require-import-etc-in-your-front-end-project-5eefcef745c2)
* [babel-example-node-server](https://github.com/babel/example-node-server)
