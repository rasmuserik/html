scale = ($elem, s) ->
  for prefix in ["", "-moz-", "-webkit-", "-o-", "-ms-"]
    $elem.css prefix + "transform-origin", "0 0"
    $elem.css prefix + "transform", "scale(#{s},#{s})"

margin = 0.5
emSize = undefined

currentSlide = (n) ->
  $slides = $ ".slide"
  colsWidth = $(window).width() / emSize - 1.5 - 2*margin - 18
  thumbsCount = $slides.length - 1
  cols = 0
  ok = true
  thumbCount = -1
  while thumbCount < $slides.length
    ++cols
    colWidth = colsWidth / cols
    thumbsPerCol = Math.ceil (19 / colWidth)
    thumbCount = thumbsPerCol * (cols - 1)
  thumbScale = (((18+margin) / thumbsPerCol) - margin) / 18

  for slide, i in $slides
    $slide = $ slide
    if i < n
      scale $slide, thumbScale
      $slide.css {
        top: margin + (i % thumbsPerCol) * (thumbScale*18 + margin) + "em",
        left: 1.5 + margin + ((i / thumbsPerCol) | 0) * (thumbScale*18 + margin) + "em"
        "box-shadow": "#{0.2/thumbScale}em #{0.2/thumbScale}em #{0.5/thumbScale}em rgba(0,0,0,0.4)"
      }
    if i is n
      scale $slide, 1
      $slide.css {
        top: margin + "em"
        left: 1.5 + margin + Math.ceil(i / thumbsPerCol) * (thumbScale*18 + margin) + "em"
        "box-shadow": "0.2}em 0.2em 0.5em rgba(0,0,0,0.4)"
      }
    if i > n
      scale $slide, thumbScale
      i = i - ($slides.length % thumbsPerCol) + thumbsPerCol
      $slide.css {
        top: margin + (i % thumbsPerCol) * (thumbScale*18 + margin) + "em",
        left: 1.5 + margin * 2 + 18 + (((i / thumbsPerCol) | 0) + 1) * (thumbScale*18 + margin) + "em"
        "box-shadow": "#{0.2/thumbScale}em #{0.2/thumbScale}em #{0.5/thumbScale}em rgba(0,0,0,0.4)"
      }

layout = (n) ->

  emSize = Math.floor (($ window).height() / (18 + margin*1.2))

  $(".header").css("top", 18 + margin + "em")



  $(document.body).css "font-size", emSize
  currentSlide(n)

slidePos = 0

next = ->
  ++slidePos
  if slidePos > ($ ".slide").length
    slidePos = 0
  layout slidePos

if Meteor.isClient
  Meteor.startup () ->
    layout slidePos
    $("body").bind "keydown", next
    $("body").bind "mousedown", next

    
#    for section in $ "section"
#      children = $(section).children "section"
#      count = children.length
#      childscale = (18 - (count - 1)) / 18 / count
#      height = 18*childscale + 1
#      for child, i in children
#        $(child).css {
#          top: i*height + "em",
#          left: "19em" }
#        scale($(child), childscale)
#    for h1 in $ "h1"
#      size = 1;
#      $h1 = $ h1
#      lineWidth = $h1.width()
#      $h1.css {
#        "display": "inline",
#        "white-space": "pre",
#        "font-size": size}
#      while $h1.width() < lineWidth and $h1.height() < lineWidth / 6
#        ++size
#        $h1.css "font-size", size
#      --size
#      $h1.css "font-size", size
#      $h1.css "display", "block"
#
