# sketch-note-draw 0.0.3

Simple sketching program, with clean interface.

- Infinite canvas
- Zoom in/out
- Also usable with one hand (single thumb)
- Automatically saves current sketch with timestamp, when loading, or creating a new one.
- Undo support

Made it because I wanted a tool to make quick sketches / napkin-notes.


TODO

- optimise for performance
  - dont have everything in memory
  - delayed full redraws when panning/zoomin
- sync with cloud storage

# Boilerplate
predicates that can be optimised away by uglifyjs

    if typeof isNodeJs == "undefined" or typeof runTest == "undefined" then do ->
      root = if typeof window == "undefined" then global else window
      root.isNodeJs = (typeof process != "undefined") if typeof isNodeJs == "undefined"
      root.isWindow = (typeof window != "undefined") if typeof isWindow == "undefined"
      root.isPhoneGap = typeof document?.ondeviceready != "undefined" if typeof isPhoneGap == "undefined"
      root.runTest = (if isNodeJs then process.argv[2] == "test" else location.hash.slice(1) == "test") if typeof runTest == "undefined"
    

use - require/window.global with non-require name to avoid being processed in firefox plugins

    use = if isNodeJs then ((module) -> require module) else ((module) -> window[module]) 

execute main

    onReady = (fn) ->
      if isWindow
        if document.readystate != "complete" then fn() else setTimeout (-> onReady fn), 17 

# Actual code

    window.devicePixelRatio ?= 1
    

## state

    strokes = []
    redo = []
    nextStroke = undefined
    nextPath = undefined
    currentStroke =
      prev: null
      path: []
      date: 1
    allStrokes =
      1: currentStroke
    transform = false
    hold = false
    
    rootX = 0
    rootY = 0
    scale = 1
    
    ctx = undefined
    kind = undefined
    multitouch = undefined
    hasTouch = false
    panPos = undefined
    
    loadGrid = false
    
    findDimensions = (stroke) -> #{{{2
      return [0,0,1,1] if !stroke || !stroke.prev
      minY = minX = Number.MAX_VALUE
      maxY = maxX = -Number.MAX_VALUE
      update = (x,y) ->
        minY = Math.min(y, minY)
        minX = Math.min(x, minX)
        maxY = Math.max(y, maxY)
        maxX = Math.max(x, maxX)
    
      while stroke && stroke.prev
        for i in [0..stroke.path.length-1] by 2
          update stroke.path[i], stroke.path[i+1]
        stroke = allStrokes[stroke.prev]
    
      return [minX, minY, maxX, maxY]
    
    scaleFit = -> #{{{2
      [minX, minY, maxX, maxY] = findDimensions currentStroke
      w = maxX - minX
      h = maxY - minY
      scale = Math.min((canvas.width - 6) / w, (canvas.height - 90) / h)
      rootX = -minX + ((canvas.width / scale) - (maxX - minX)) / 2
      rootY = -minY + ((canvas.height / scale) - (maxY - minY)) / 2
    

## draw+layout

    redraw = ->
      return drawGrid() if loadGrid
      ctx.fillStyle = "white"
      ctx.fillRect 0, 0, canvas.width, canvas.height
      ctx.fillStyle = "black"
      ctx.lineWidth = Math.sqrt(canvas.width * canvas.height) * 0.002
    
      stroke = currentStroke
      ctx.strokeStyle = "black"
      while stroke && stroke.prev
        path = stroke.path
        ctx.beginPath()
        ctx.moveTo (path[0] + rootX) * scale, (path[1] + rootY) * scale
        for i in [2..path.length] by 2
          ctx.lineTo (path[i] + rootX) * scale, (path[i + 1] + rootY) * scale
        ctx.stroke()
        stroke = allStrokes[stroke.prev]
    
    drawSegment = (x0, y0, x1, y1) ->
      ctx.beginPath()
      ctx.moveTo (x0 + rootX) * scale, (y0 + rootY) * scale
      ctx.lineTo (x1 + rootX) * scale, (y1 + rootY) * scale
      ctx.stroke()
    
    layout = ->
      canvas.style.position = "absolute"
      canvas.style.top = "0px"
      canvas.style.left = "0px"
      canvas.height = window.innerHeight * window.devicePixelRatio | 0
      canvas.width = window.innerWidth * window.devicePixelRatio | 0
      canvas.style.width = "#{window.innerWidth}px"
      canvas.style.height = "#{window.innerHeight}px"
    
      info = document.getElementById "info"
      info.style.fontSize = "#{Math.min(window.innerHeight, window.innerWidth) >> 4}px"
      info.style.left = "0px"
      info.style.width = "#{window.innerWidth}px"
      info.style.top = "#{(window.innerHeight-info.offsetHeight) * 0.4}px"
    
      addButtons()
      redraw()

## Utility

    dist = (x0,y0,x1,y1) ->
      dx = x0 - x1
      dy = y0 - y1
      Math.sqrt(dx*dx + dy*dy)
    

## load grid

    gridSize = 60 * window.devicePixelRatio | 0
    gridMargin = 10 * window.devicePixelRatio | 0
    gridNext = undefined
    gridStart = undefined
    gridX0 = undefined
    gridY0 = undefined
    gridCols = undefined
    gridEvents = undefined
    uu.log "starting sketch-note-draw"
    
    calcPos = (w) -> #{{{3
      count = (w - gridMargin) / (gridSize+gridMargin) | 0
      totalMargin = w - count * gridSize
      indent = (w - gridMargin*(count-1) - count * gridSize) >> 1
      return (indent + (i*(gridSize + gridMargin)) for i in [0..count-1])
    
    drawEntry = (entry, i, count, x, y) -> #{{{3
      if 1 == i
        drawing = {prev: null, path: []}
        texts = ["new", ""]
        next = gridNext
        fn = ->
          currentStroke = allStrokes[1]
          loadGridExit()
      else if 2 == i
        drawing = currentStroke
        texts = ["current", ""]
        next = gridNext
        fn = -> loadGridExit()
      else if count == i && gridNext && gridNext.prevSave
        drawing = {prev: null, path: []}
        texts = ["more", ""]
        next = gridNext
        fn = ->
          gridStart = gridNext
          redraw()
      else
        return if !gridNext
        drawing = gridNext
        d = new Date(drawing.date)
        texts = [
          d.toString().split(" ")[4]
          d.toString().split(" ").slice(1,3).join(" ")
          ]
        next = allStrokes[drawing.prevSave] if drawing.date != drawing.prevSave
        fn = ->
          currentStroke = drawing
          loadGridExit()
    
      gridEvents.push fn
    
      ctx.fillStyle = "black"
      ctx.fillRect x-1,y-1,gridSize+2,gridSize+2
      ctx.fillStyle = "white"
      ctx.fillRect x,y,gridSize,gridSize
    

#### find drawing dimension

      [minX, minY, maxX, maxY] = findDimensions drawing
    
      size = Math.max(maxX - minX, maxY - minY)
      px = minX - (size - (maxX - minX)) / 2
      py = minY - (size - (maxY - minY)) / 2
      rescale = gridSize / size
    

#### draw

      ctx.lineWidth = 1
      stroke = drawing
      ctx.strokeStyle = "black"
      while stroke && stroke.prev
        ctx.beginPath()
        for i in [2..stroke.path.length-1] by 2
          ctx.lineTo x+(stroke.path[i]-px)*rescale, y+(stroke.path[i+1]-py)*rescale
        ctx.stroke()
        stroke = allStrokes[stroke.prev]
    

#### text

      fontSize = (gridSize*.25) | 0
      ctx.font = "#{fontSize}px sans-serif"
      ctx.fillStyle = "rgba(255,255,255,0.4)"
      for dx in [-window.devicePixelRatio..window.devicePixelRatio] by window.devicePixelRatio * .5
        for dy in [-window.devicePixelRatio..window.devicePixelRatio] by window.devicePixelRatio * .5
          ctx.fillText texts[0], x + fontSize * .2 + dx, y + fontSize * 1 + dy
          ctx.fillText texts[1], x + fontSize * .2 + dx, y + fontSize * 2 + dy
      ctx.fillStyle = "black"
      ctx.fillText texts[0], x + fontSize * .2, y + fontSize * 1
      ctx.fillText texts[1], x + fontSize * .2, y + fontSize * 2
    

#### done

      gridNext = next
    
      
    drawGrid = -> #{{{3
      gridEvents = []
      gridNext = gridStart
      ctx.fillStyle = "white"
      ctx.fillRect 0, 0, canvas.width, canvas.height
      xs = calcPos +canvas.width
      ys = calcPos +canvas.height
      gridX0 = xs[0]
      gridY0 = ys[0]
      gridCols = xs.length
      entry =
        stroke: currentStroke
        text: "new"
      i = 0
      count = ys.length * xs.length
      for y in ys
        for x in xs
          ++i
          entry = drawEntry entry, i, count, x, y
    
    save = -> #{{{3
      return if currentStroke.prevSave || 1 == currentStroke.date
      cs = currentStroke
      localforage.getItem "sketchSaved", (sketchId) ->
        cs.prevSave = sketchId
        localforage.setItem "sketchStroke#{cs.date}", cs
        localforage.setItem "sketchSaved", cs.date
    
    showLoadGrid = -> #{{{3
      gridStart = currentStroke
      document.getElementById("info").style.opacity = "0"
      uu.sleep 1, -> document.getElementById("info").style.display = "none"
      (document.getElementById "buttons").style.display = "none"
      loadGrid = true
      save()
      localforage.getItem "sketchSaved", (sketchId) ->
        gridStart = allStrokes[sketchId || 1]
        redraw()
    
    loadGridExit = ->
      (document.getElementById "buttons").style.display = "inline"
      loadGrid = false
      scaleFit()
      redraw()
    
    loadGridHandleTouch = (x0,y0) -> #{{{3
      x = (x0 - gridX0) / (gridSize + gridMargin) | 0
      y = (y0 - gridY0) / (gridSize + gridMargin) | 0
      (gridEvents[x + y * gridCols] || loadGridExit)()
    
    

## buttons

    buttonList = ["pan", "files", "undo", "pan", "pan", "zoomin", "zoomout", "pan"]
    
    buttonAwesome =
      pan: "arrows"
      zoomin: "search-plus"
      zoomout: "search-minus"
      undo: "undo"
      redo: "repeat"
      new: "square-o"
      download: "picture-o"
      save: "cloud-upload gray"
      load: "cloud-download gray"
      info: "question"
      files: "th"
    
    zoomFn = ->
      if "zoomin" == kind || "zoomout" == kind
        setTimeout zoomFn, 20
        zoomScale = if kind == "zoomin" then 1.05 else 1/1.05
        scale *= zoomScale
        rootX += canvas.width / scale * (1 - zoomScale) / 2
        rootY += canvas.height / scale * (1 - zoomScale) / 2
        setTimeout redraw, 0
    
    buttonFns =
      pan: -> panPos = undefined
      files: showLoadGrid
      download: ->

##

        a = document.createElement "a"
        a.download = "sketch-note-draw.png"
        a.href = canvas.toDataURL()
        a.target = "_blank"
        document.body.appendChild a
        a.click()
        document.body.removeChild a

##

        window.open canvas.toDataURL()
      zoomin: zoomFn
      zoomout: zoomFn
      undo: -> if currentStroke.prev
        redo.push currentStroke
        currentStroke = allStrokes[currentStroke.prev]
        redraw()
      redo: -> if redo.length
        currentStroke = redo.pop()
        redraw()
      new: -> if strokes.length
        currentStroke = allStrokes[1]
        redraw()
    
    addButtons = ->
      buttons = document.getElementById "buttons"
      buttons.innerHTML = ""
      for i in [0..buttonList.length - 1]
        buttonId = buttonList[i]
        button = document.createElement "i"
        button.className = "fa fa-#{buttonAwesome[buttonId]}"
        ((buttonId) ->
          touchhandler = (e) ->
            e.stopPropagation()
            e.preventDefault()
            kind = buttonId
            buttonFns[buttonId]?()
          button.ontouchstart = (e) -> hasTouch = true; touchhandler e
          button.onmousedown = (e) -> (touchhandler e if !hasTouch)
        )(buttonId)
        button.style.WebkitTapHighlightColor = "rgba(0,0,0,0)"
        button.style.tapHighlightColor = "rgba(0,0,0,0)"
        button.style.position = "absolute"
        button.style.fontSize = "36px"
        button.style.padding = "4px"
        button.style.top = if i < buttonList.length/2 then "0px" else "#{window.innerHeight - 44}px"
        s = (window.innerWidth - buttonList.length/2*44) / (buttonList.length/2 - 1) + 44
        button.style.left = "#{(i % (buttonList.length/2)) * s}px"
        buttons.appendChild button
    

## touch

    touchstart = (x,y) ->
      return loadGridHandleTouch(x,y) if loadGrid
      document.getElementById("info").style.opacity = "0"
      uu.sleep 1, -> document.getElementById("info").style.display = "none"
      nextPath = [x/scale-rootX, y/scale-rootY]
      nextStroke =
        prev: currentStroke.date
        path: nextPath
        date: Date.now()
      kind = "draw"
      multitouch = undefined
    
    touchend = ->
      if "draw" == kind
        allStrokes[nextStroke.date] = nextStroke
        localforage.setItem "sketchStroke#{nextStroke.date}", nextStroke
        localforage.setItem "sketchCurrent", nextStroke.date
        currentStroke = nextStroke
      kind = "end"
    
    touchmove = (x0, y0, x1, y1) ->
      if "draw" == kind
        x = (x0) / scale - rootX
        y = (y0) / scale - rootY
        drawSegment nextPath[nextPath.length - 2], nextPath[nextPath.length - 1], x, y
        nextPath.push x, y
    
      if "pan" == kind
        if panPos
          rootX += (x0 - panPos.x) / scale
          rootY += (y0 - panPos.y) / scale
          redraw()
    
        panPos =
          x: x0
          y: y0
    
    
      if "number" == typeof x1
        kind = "multitouch"
        if ! multitouch
          kind = "multitouch"
          multitouch =
            x: (x0 + x1) / 2 / scale - rootX
            y: (y0 + y1) / 2 / scale - rootY
            dist: dist x0, y0, x1, y1
            rootX: rootX
            rootY: rootY
            scale: scale
        else
          current =
            x: (x0 + x1) / 2 / multitouch.scale - multitouch.rootX
            y: (y0 + y1) / 2 / multitouch.scale - multitouch.rootY
            dist: dist x0, y0, x1, y1
          scale = multitouch.scale * current.dist / multitouch.dist
          rootX = (current.x + multitouch.rootX) * multitouch.scale / scale - multitouch.x
          rootY = (current.y + multitouch.rootY) * multitouch.scale / scale - multitouch.y
          uu.nextTick redraw()
    

## loadDB

    loadDB = ->
      doFetch = []
      current = undefined
      visited = {}
      fetchAll = ->
        id = doFetch.pop()
        if !visited[id]
          localforage.getItem "sketchStroke#{id}", (stroke) ->
            fetchAll()
            if stroke
              allStrokes[id] = stroke
              doFetch.push stroke.prev if stroke.prev
              doFetch.push stroke.prevSave if stroke.prevSave
            return done() if doFetch.length == 0
          visited[id] = true
        else
          uu.nextTick fetchAll
    
      done = ->
        window.navigator?.splashscreen?.hide?()
        currentStroke = allStrokes[current] || currentStroke
        redraw()
    
      localforage.getItem "sketchCurrent", (id) ->
        current = id
        doFetch.push current
        localforage.getItem "sketchSaved", (saved) ->
          doFetch.push saved
          fetchAll()
    

## onReady

    onReady ->
      loadDB()
      ctx = canvas.getContext "2d"
      layout()
    
      uu.domListen window, "touchstart", (e) ->
        e.preventDefault()
        hasTouch = true
        touchstart(e.touches[0].clientX * devicePixelRatio, e.touches[0].clientY * devicePixelRatio) if 1 == e.touches.length
    
      uu.domListen window, "mousedown", (e) ->
        e.preventDefault()
        touchstart(e.clientX * devicePixelRatio, e.clientY * devicePixelRatio) if !hasTouch
    
      uu.domListen window, "touchmove", (e) ->
        e.preventDefault()
        args = []
        for touch in e.touches
          args.push touch.clientX * devicePixelRatio
          args.push touch.clientY * devicePixelRatio
        touchmove args...
    
      uu.domListen window, "mousemove", (e) ->
        e.preventDefault()
        touchmove e.clientX * devicePixelRatio, e.clientY * devicePixelRatio
    
    
      uu.domListen window, "touchend", (e) -> touchend()
      uu.domListen window, "mouseup", (e) -> (touchend() if !hasTouch)
      uu.domListen window, "resize", (e) -> layout()
    
    window.onerror = (e) ->
      uu.log "error", String(e)
    

----

README.md autogenerated from `sketch-note-draw.coffee` ![solsort](https://ssl.solsort.com/_reputil_rasmuserik_sketch-note-draw.png)
