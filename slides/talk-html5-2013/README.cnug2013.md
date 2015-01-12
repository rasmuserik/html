# ![logo](https://solsort.com/_logo.png) HTML5 - a developer perspective
 
Presentation at http://cnug.dk/, 2013 May 22.

This repository contains preliminary notes, slides and code for the talk.

## Description

HTML5 – a developer perspective
Posted on April 15, 2013 by Anders Lybecker 

CopenhagenJS and CNUG presents Rasmus Erik.

### Abstract

HTML5/JavaScript is the widest deployed client application platform.
First, we start out with a helicopter view of the state of the APIs
from a developer perspective to get a taste of the platform. Then, in
the second part we dive in and take a look at the actual code, by
touching on some concrete examples using different parts of the APIs.

### Bio

Rasmus Erik is a freelance computer scientist, whose experience
include professional software development, consulting, coaching,
teaching, and various talks. Read more on `rasmuserik.com` and follow `@rasmuserik_com`

### When 
22th May 2013 at 7 pm.

## Outline

- Introduction
    - Point of view of talk
        - my background
        - what is HTML5
    - Table of contents
        - Overview of the 
- State and overview of the APIs
    - GUI
        - Graphics: canvas, svg, webgl
        - Media: audio, video, media-capture, webrtc
        - CSS3: media queries, animations, shadow, 3d-transform, fonts...
        - Input: touch, device-orientation, geolocation
        - Misc: MathML, fullscreen, contenteditable, drag-n-drop
    - System
        - Storage: localStorage, websql, indexeddb, fileapi
        - Network: websockets, xhr2(cors, binary), protocol handlers, webrtc
        - Code execution: webworkers, cross-document-messaging, offline-apps, async script loading
        - Misc: typed arrays, history api, microdata/semantic-web
- Concrete examples
    - Intro
        - Disclaimer, pure html5+js, no abstraction layer, demonstration code, not best practises, only chrome
    - HTML5 platform live code examples
        - Architecture of html5 document (doctype+parser(ie.utf8 no quotes))
        - Video 
        - css3 - box-shadow, round corners
        - Canvas (pixel access, typed arrays)
        - Video capture
        - localstorage
        - semantic markup, content editable
        - fullscreen, ie. canvas
    - Realworld examples
        - Languages, coffeescript: legoland-billund-resort
        - Libraries, d3.js: dragimation
        - Not just browser, - ie. canvas server-side, physical card games made with HTML5!
        - Emscripten Unreal-engine + hello world: Unreal Engine (C++, 1+MLoC, 2013, ported in 4 days!, https://www.youtube.com/watch?v=MyAcKgr6mZU, emscripten, asm.js)


## TODO

- write slides from outline
- runtime-environment - simple web-server
- practise presentation 
- timer in slides
- html5.solsort.com - collection of presentations.
