#{{{1 setup
w = h = 1000
framewait = 30
dirStep = 0.1
stepSize = 8
sectionSize = 6
canvas = undefined
ctx = undefined
t0 = Date.now()

score = 0

score = head = body = undefined
berry =
  x: 500
  y: 500

newBerry = ->
  ctx.beginPath()
  ctx.arc berry.x, berry.y, sectionSize*4+1, 0, Math.PI*2
  ctx.fillStyle = "#002"
  ctx.fill()
  ++score
  berry =
    x: Math.random() * 800 + 100
    y: Math.random() * 800 + 100
  ctx.beginPath()
  ctx.arc berry.x, berry.y, sectionSize*4, 0, Math.PI*2
  ctx.fillStyle = "#0f0"
  ctx.fill()

start = ->
  document.body.innerHTML = "<canvas style=\"position:absolute;top:0;left:0;width:100%;height:100%\" id=\"canvas\" width=#{w} height=#{h}></canvas>"
  canvas = document.getElementById("canvas")
  ctx = canvas.getContext "2d"

  ctx.fillStyle = "#002"
  ctx.fillRect 0,0,1000,1000
  ctx.fillStyle = "#fff"
  ctx.fillRect 5,5,990,990
  ctx.fillStyle = "#002"
  ctx.fillRect 15,15,970,970
  score = 0
  newBerry()
  head =
    x: w/2
    y: h/2
    dir: 0
    dirStep: dirStep
  body = []
  gameloop()
  document.body.onkeydown = document.body.onmousedown = document.body.ontouchstart = (e) -> head.dirStep = -dirStep
  document.body.onkeyup = document.body.onmouseup = document.body.ontouchend = (e) -> head.dirStep = dirStep

die = ->
  i = 0
  dieLoop = ->
    if i > 10
      setTimeout start, 1000
      return
    ctx.fillStyle = "rgba(0,0,32,0.3)"
    ctx.fillRect(0,0,1000,1000)
    ctx.fillStyle = "rgba(0,255,0,1)"
    ctx.font = "200px sans serif"
    ctx.fillText "#{score-1}•", 300, 500
    console.log "here", i
    ++i
    setTimeout dieLoop, 30
  setTimeout dieLoop, 0

gameloop = ->
  startTime = Date.now()
  body.push
    x: head.x
    y: head.y
  head.x += Math.sin(head.dir) * stepSize
  head.y += Math.cos(head.dir) * stepSize
  head.dir += head.dirStep
  p = ctx.getImageData(head.x,head.y,1,1).data
  if p[0]
    return die()
  else if p[1]
    newBerry()

  ctx.beginPath()
  ctx.arc head.x, head.y, sectionSize, 0, Math.PI*2
  ctx.fillStyle = "#f00"
  ctx.fill()
  if body.length > score * 30
    tail = body.shift()
    ctx.beginPath()
    ctx.arc tail.x, tail.y, sectionSize + 2, 0, Math.PI*2
    ctx.fillStyle = "rgba(0,0,0,1)"
    ctx.fill()
  setTimeout gameloop, Math.max(0, framewait - (Date.now() - startTime))

start()

document.addEventListener "deviceready", start, false


