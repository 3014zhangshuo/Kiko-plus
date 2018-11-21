---
layout: post
title: 'Javascript: Canvas To Image'
date: 2018-07-06 9:30:00
comments: true
tags: [javascript]
share: false
---
### Example Code

```
var canvas = document.getElementById("myCanvas");
var ctx = canvas.getContext("2d");

baseimage = new Image();
baseimage.onload = function() {
    ctx.drawImage(baseimage,1,1);    
    var dataURL = canvas.toDataURL("image/png");
    document.getElementById('canvasImg').src = dataURL;
}
baseimage.src = 'what.jpg';
```

### Canvas Blurring Resolve

```
ctx.webkitImageSmoothingEnabled = false;
ctx.mozImageSmoothingEnabled = false;
ctx.imageSmoothingEnabled = false; /// future
```

```
canvas {
    image-rendering: optimizeSpeed;             // Older versions of FF
    image-rendering: -moz-crisp-edges;          // FF 6.0+
    image-rendering: -webkit-optimize-contrast; // Webkit (non standard naming)
    image-rendering: -o-crisp-edges;            // OS X & Windows Opera (12.02+)
    image-rendering: crisp-edges;               // Possible future browsers.
    -ms-interpolation-mode: nearest-neighbor;   // IE (non standard naming)
}
```

[Canvas](https://www.jianshu.com/p/cb9e5300856b)
[CanvasDoc](https://developer.mozilla.org/zh-CN/docs/Web/API/CanvasRenderingContext2D/drawImage)
[CanvasToImage](https://stackoverflow.com/questions/15811897/how-to-save-a-canvas-with-image-to-a-png-file)
[CanvasBlurring](https://stackoverflow.com/questions/18547042/resizing-a-canvas-image-without-blurring-it)
