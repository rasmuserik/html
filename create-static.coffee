#!/usr/bin/env coffee
jsonml2html = require "jsonml2html"

# {{{1 list of applications
# {{{2 actual list
apps =
  rasmuserik:
    name: "Rasmus Erik Voel Jensen"
    desc: "Creator of these things.<br>Feel free to contact."
    icon: "rasmuserik.jpg"
    tags:  "computer scientist"
    kind: "Person"
    links:
      info: "rasmuserik.html"
      "email": "javascript:window.location.href='mai\\u006cto:rasmuserik\\x40solsort.com'"
      sms: "sms:+4560703081"
      git_hub: "https://github.com/rasmuserik"

  product:
    name: "Product"
    desc: ""
    icon: "notes.jpg"
    tags: "apps, visualisations, html5, open data, it-consulting"
    links:
      notes: "/notes/product"

  "relvis":
    name: "Visualisering af relationer"
    icon: "relvis.png"
    date: "2014-12-19"
    tags: "bibliotek, library, DDB-CMS, visualisation, d3, statistik, relationer"
    desc: "Grafisk visualisering af biblioteksmaterialer. Bemærk kører nogle gange langsomt pga. de eksterne data den skal hente, evt. genindlæs og vent."
    links:
      demo_berlin: "http://ssl.solsort.com/visualisering-af-relationer/solsort-related.html#relvis/cir870970-basis:29970874"
      sammenlign_webservices: "/visualisering-af-relationer/compare.html#relvis/cir870970-basis:05625351"
      vejlebib_anbefalinger: "https://vejlebib.dk/ting/object/870970-basis%3A28607733#relvis/cir870970-basis:29970874"
      "vejlebib_gå på opdagelse": "https://vejlebib.dk/ting/object/870970-basis%3A27267912#relvis/ext870970-basis:27267912"
      søgeresultater_kontrabas: "/visualisering-af-relationer/solsort-related.html#relvis/str870971-tsart:88574680,870971-tsart:87163652,870971-avis:72097580,870970-basis:01520873,870970-basis:02218453,870970-basis:02686082,870970-basis:08343748,870970-basis:03121291,870970-basis:25452712,870970-basis:25452739,870970-basis:25452747,870970-basis:25452771,870970-basis:03849341,870970-basis:03849368,870970-basis:03614514,870970-basis:22239295,870970-basis:50628892,870970-basis:43046578,870970-basis:02379783,870970-basis:02436930,870970-basis:02686112,820010-katalog:5255110__1,820010-katalog:5255110__2,820010-katalog:5255110__3,870970-basis:29956782,870970-basis:26406552,870970-basis:20734299,870970-basis:02686031,870970-basis:02686147,870970-basis:21973211"
      git_hub: "https://github.com/solsort/visualisering-af-relationer"
      "github_data": "https://github.com/vejlebib/visual_relation_server"

  "sketch-note":
    name: "Sketch note draw"
    icon: "sketch-note-draw.png"
    date: "2014-04-11"
    tags: "sketch, draw, prototype, infinite canvas, zoomable"
    desc: "Zoomable infinite canvas prototype for drawing."
    links:
      web_app: "sketch-note-draw/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.sketch_note_draw"

  "frie sange":
    name: "Frie børnesange"
    icon: "frie-sange.png"
    date: "2014-03-22"
    tags: "børnesange, open content, sangbog"
    desc: "Udvalgte børnesange uden ophavsretslige begrænsninger, som derfor kan deles og anvendes frit"
    links:
      web_app: "frie-sange/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.frie_sange"

  "morse-code":
    name: "Learn morse code tapping"
    icon: "morse-code.png"
    date: "2014-03-15"
    tags: "morse code, education"
    desc: "Learn morse code (to blindtype on smartphones). Practise writing english words, learning a new letter at a time, and keep track of level/score."
    links:
      web_app: "morse-code/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.morse_code"

  "single-toush-snake":
    name: "Interface experiment: snake game"
    icon: "single-touch-snake.png"
    date: "2014-03-01"
    tags: "experiment, game, snake, single afternoon"
    desc: "one button / binary user input - game experiment to explore this interaction pattern"
    links:
      web_app: "single-touch-snake/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.single_touch_snake"

  "Circle flow graph":
    name: "Circle flow graph"
    icon: "circle-flow-graph.png"
    date: "2014-02-26"
    tags: "experiment, non-interactive, visualisation, circles"
    desc: "visual layot experiment for dependency-like graph"
    links:
      experiment_www: "circle-flow-graph/"


  "Parkering i københavn":
    name: "Parkering i københavn"
    icon: "kbh-parking.png"
    date: "2014-02-22"
    tags: "app, hackathon, open data day, okfn, data.kk.dk, gatesense, iotpeople"
    desc: "Visualisering af hvor der sandsynligvis er frie parkeringspladser"
    links:
      web_app: "kbh-parking/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.kbh_parking"

  "onetwo360":
    name: "360º Viewer"
    icon: "360-viewer.jpg"
    date: "2014-02"
    tags:  "widget, frontend, onetwo360.com, hammertime"
    desc: "Viewer for 360º images (pseudo-3d rotateable)"
    links:
      demo_www: "360/test"

  "uccorg":
    name: "Backend for <nobr>UCC-organismen</nobr>"
    icon: "uccorg.png"
    date: "2014-01"
    tags: "backend, ucc, rejseplanen"
    desc: "Backend for art projekt: processing information from various source, server setup and delivering an API, events, and dashboard"
    links: []

  "bibtek-konf":
    name: "BibTekKonf presentation"
    icon: "bibtek-konf.png"
    date: "2013-10-26"
    tags:  "slides, done, presentation, bibtekkonf, bibgraph, dbc"
    desc: "BibTekKonf præsentation om visua&shy;lisering ud fra DBCs \"Andre Der Har Lånt\"-data"
    links:
      slides: "/slides/bibtekkonf2013-bibgraph"

  "music-131023":
    music: "131023"
    date: "2013-10-23"
    tags:  "scores, classical"
    type: "music"
    links: {}

  mmm:
    music: "131023"
    date: "2013-10-23"
    tags:  "scores, sad"
    type: "music"
    links: {}

  "hack4dk-art-quiz":
    name: "Art Quiz"
    date: "2013-09-28"
    desc: "Hack4dk hackathon hack: touch friendly art quiz using open images from <nobr>Statens Museum for Kunst</nobr>"
    icon: "h4dk-artquiz.jpg"
    tags:  "app, prototype, hack4dk, touch friendly, dynamic layout"
    links:
      web_app: "/hack4dk/quiz/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.art_quiz"

      
  "hack4dk-image-recognition":
    name: "Simple Image Recognition"
    date: "2013-09-28"
    icon: "h4dk-imrec.jpg"
    desc: "Hack4dk hackathon hack: pure javascript to distinguish between differen kind of images from \"politiets registerblade\" open data set. Just some utility code needed by another team"
    tags:  "code, utility"
    links:
      demo_www: "/hack4dk/imextract/"

  "hack4dk-wikipedia-graph-visualisation":
    name: "Wikipedia Link&nbsp;Graph"
    date: "2013-09-28"
    desc: "Hack4dk hackathon hack: graph visualisation from wikipedia"
    icon: "h4dk-wiki-graph.png"
    tags:  "visualisation, prototype, d3"
    links:
      demo_www: "/hack4dk/d3wikipedia/?Open+data"

  "summer-hacks":
    name: "Summer Hacks"
    title: "Slides: Summer Hacks"
    icon: "summer-hacks.png"
    date: "2013-08-14"
    tags:  "slides, copenhagenjs, presentation, bibgraph, skolevej"
    desc: "Slides for presentation at CopenhagenJS on various summer hacks: BibGraph and Skolevej"
    links:
      slides: "/slides/cphjs2013-summer-hacks"

  bibgraph:
    name: "BibGraph"
    date: "2013-08-02"
    icon: "bibgraph.png"
    tags: "visualisation, widget, dbc, adhl, d3, graph"
    desc: "Visualisation of relations between books and other library materials, generated from the ADHL statistics about danish <nobr>co-loans</nobr>"
    links:
      demo_www: "http://dbc-bibgraph.solsort.com/"
      www: "http://labs.dbc.dk/bibgraph"
      #github: "rasmuserik/DBCDK/bibgraph"

  skolevej:
    name: "Skolevej"
    date: "2013-07-08"
    tags: "widget, prototype, hammertime, gis, leaflet, openstreetmap"
    desc: "Demo/frontend of editor for safe school routes - made for Hammertime / Odense Kommune"
    icon: "skolevej.png"
    links: {}

  html5cnug:
    name: "HTML5 - a developer perspective"
    date: "2013-05-22"
    icon: "html5cnug.png"
    tags: "slides-tech-talks, presentation, html5, cnug"
    desc: "Slides for presentation done at CNUG.dk"
    time: "3 days study/preparation for presentation, 1 hour presentation"
    type: "presentation"
    links:
      slides: "slides/talk-html5-2013/cnug2013-slides.html#/"

  speeding:
    state: "production"
    role: "optimisation / reimplementation to solve performance issue"
    name: "Speeding visualisation"
    icon: "speeding.png"
    tags: "widgets, hammertime, visualisation, role:optimisation, role:reimplementation"
    date: "2013-05-15"
    desc: "Visualiseringskode for vejdirektoratet - layout baseret på tidligere udgave"
    time: "5 hours trying to optimise original outsourced code, then 10 hours reimplementing it"
    links:
      demo_www: "http://speeding.solsort.com"
      www: "http://www.vejdirektoratet.dk/da/trafik/planl%C3%A6g%20turen/voresfart/sider/default.aspx"

  "productivity-hacks":
    icon: "notes.jpg"
    name: "Productivity Hacks"
    desc: "Notes for a presentation on productivity hacks. Keywords of my aproaches to handle the world."
    date: "2013-04-30"
    type: "writings"
    tags:  "notes"
    links:
      notes: "/notes/productivity-hacks"

  dragimation:
    name: "Dragimation"
    date: "2013-04-30"
    icon: "dragimation.png"
    tags:  "widgets, hammertime, visualisation, html5"
    desc: "Dragging animation special effect - as requested for the development of legoland billund resort web page."
    links:
      demo_www: "http://dragimation.solsort.com"
      www: "http://www.legolandbillundresort.com"

  "pricing-scale":
    icon: "notes.jpg"
    name: "Pricing scale"
    desc: "Tool for pricing and estimating cost."
    date: "2013"
    type: "writings"
    tags:  "notes"
    links:
      notes: "/notes/pricing-scale"

  tsartnoc:
    name: "Tsar Tnoc"
    desc: "Result of a ludum dare hackathon."
    icon: "tsar-tnoc.png"
    date: "2012-07-15"
    tags:  "app, game, ludum dare, hackathon"
    links:
      web_app: "/tsartnoc/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.tsartnoc"

  eurocards:
    name: "EuroCards"
    tags:  "cardgames, card game"
    icon: "eurocards.jpg"
    desc: "top-trump like card game for learning facts about european countries"
    date: "2012-06-20"
    type: "physical"
    links:
      about: "/notes/eurocards"
      game_crafter: "https://www.thegamecrafter.com/games/EuroCards"

  blobshot:
    name: "BlobShot"
    desc: "Result of the 5apps hackathon."
    date: "2012-05-06"
    icon: "blobshot.png"
    tags: "app, game, hackathon"
    links:
      web_app: "blobshot/"
      android_app: "https://play.google.com/store/apps/details?id=com.solsort.blobshot"

  combigame:
    name: "CombiGame"
    desc: "Logical game, inspired by a card game"
    date: "2012-03-26"
    icon: "combigame.png"
    tags:  "app, game"
    links:
      "web_app": "http://old.solsort.com/#combigame"
      "android_app": "https://play.google.com/store/apps/details?id=com.solsort.combigame"
      game_crafter: "https://www.thegamecrafter.com/games/CombiGame"
      #iOS_app: "com.solsort.combigame"

  "presentation-evaluation":
    icon: "notes.jpg"
    name: "Presentation evaluation notes"
    desc: "Checklist / notes for giving feedback on presentations. Useful for Toastmasters and similar."
    date: "2012-03-18"
    tags: "notes, toastmasters, evaluation"
    links:
      notes: "/notes/presentation-evaluation"

  notescore:
    name: "NoteScore"
    desc: "Note learning app"
    android: "dk.solsort.notescore"
    date: "2011-08"
    icon: "notescore.png"
    tags: "app, edutainment, music"
    links:
      web_app: "/notescore"
      android_app: "https://play.google.com/store/apps/details?id=dk.solsort.notescore"

  dkcities:
    name: "Danske Byer"
    desc: "Learning \"game\" for the geography of Denmark."
    date: "2011-08"
    icon: "dkcities.png"
    tags: "app, edutainment"
    links:
      web_app: "/danske-byer"
      android_app: "https://play.google.com/store/apps/details?id=com.rasmuserik.dkcities"

  cuteengine:
    name: "CuteEngine"
    desc: "Game engine experiment"
    date: "2011-08"
    time: "3 days"
    tags: "app, prototype, unfinished, game"
    icon: "cuteengine.png"
    links:
      web_app: "/cute-engine"

  "a-tango-unfinished":
    music: "070113-tango"
    date: "2007-01-13"
    tags:  "scores, tango"
    type: "music"
    links: {}

  "music-070113":
    music: "070113"
    date: "2007-01-13"
    tags:  "scores, classical"
    type: "music"
    links: {}

  elala:
    music: "070102-elala"
    date: "2007-01-02"
    tags:  "scores, classical chord-progression"
    type: "music"
    links: {}

  rosa:
    music: "070101-rosa.midi"
    date: "2007-01-01"
    tags:  "scores, tango"
    type: "music"
    links: {}

  drommespejl:
    music: "061231-song"
    date: "2006-12-31"
    tags:  "scores, sad"
    type: "music"
    links: {}

  "tango-tema-del-ultimo-2006":
    music: "061231-tango-tema"
    date: "2006-12-31"
    tags:  "scores, tango"
    type: "music"
    links: {}

  "untitled-nuevo-tema":
    music: "061231-tango-nuevo-tema"
    date: "2006-12-31"
    tags:  "scores, tango"
    type: "music"
    links: {}

  "ca-ra-ca-fu":
    music: "061227-ca-ra-ca-fu"
    date: "2006-12-27"
    tags:  "scores, digitisation"
    desc: "Digitisation/typesetting of an out-of-copyright tango score"
    type: "music"
    links: {}

  skrivetips:
    icon: "notes.jpg"
    name: "Skrivetips"
    lang: "da"
    desc: "Tips / noter om skrivning, herunder også struktur for videnskabelige rapporter. Tips for effective writing (in Danish)."
    date: "2005"
    type: "writings"
    tags:  "notes"
    links:
      notes: "/notes/skrivetips"

# {{{2 Date missing

  "f1k-brownian":
    desc: "fading random cloudsw generated through brownian noise in 127bytes"
    type: "apps"
    tags:  "demo"
    links: {}

  structcomp:
    tags:  "computerscience, thesis bsc"
    type: "writings"
    links: {}

  billeder:
    todo: "tegninger"
    type: "meta"
    tags:  "TODO"
    links: {}

  moblang:
    tags:  "computerscience, thesis msc"
    type: "writings"
    links: {}

  "vejviser-workflow":
    url: "http://pocr.sourceforge.net/"
    type: "apps"
    tags:  "apps"
    links: {}

  "iva-paper":
    tags:  "computerscience, article"
    type: "writings"
    links: {}

  "vejviser-korrektur":
    type: "apps"
    tags:  "apps"
    links:
      online: "http://kbh-vejviser.dk"

  "tempo-paper":
    tags:  "computerscience, article"
    type: "writings"
    links: {}

  bibdata:
    desc: "mobile+linked-data frontend for library"
    type: "apps"
    tags:  "protoapps"
    links: {}

  "lightscript-old":
    type: "code"
    tags:  "languages"
    links:
      github: "rasmuserik/lightscript-old"
      html5: "thesis"

  "f1k-rain":
    todo: "todo"
    type: "apps"
    tags:  "demo"
    links: {}

  "combigame-card":
    desc: "Card game version of combigame"
    type: "physical"
    tags:  "cardgames"
    links: {}

  "f1k-sierp":
    desc: "sierpinski triangle in 70bytes"
    type: "apps"
    tags:  "demo"
    links: {}

  "design-og-evaluering-af-et-introducerende-datalogikursus":
    todo: "todo"
    type: "physical"
    tags:  "print"
    links: {}

  "yolan-editor":
    todo: "probably remove due to security"
    type: "apps"
    tags:  "demo"
    links: {}

  yolan:
    type: "code"
    tags:  "languages"
    links:
      github: "rasmuserik/yolan"

  "hier-brows":
    todo: "todo"
    type: "apps"
    tags:  "demo"
    links: {}

  lightscript:
    type: "code"
    tags:  "languages"
    links:
      github: "rasmuserik/lightscript"

  "diamond-square-plasma":
    desc: ""
    type: "apps"
    tags:  "demo"
    links: {}

  jsxml:
    npmjs: "jsxml"
    type: "code"
    tags:  "lib"
    links:
      github: "rasmuserik/jsxml"

  "js-beautify":
    todo: "todo"
    type: "code"
    tags:  "oss-contrib"
    links: {}

  "uccorg-backend":
    type: "code"
    tags:  "lib"
    links:
      github: "rasmuserik/UCC-Organism/uccorg-backend"

  "firefox-e4x":
    todo: "todo"
    type: "code"
    tags:  "oss-contrib"
    links: {}

  jsonml2html:
    npmjs: "jsonml2html"
    type: "code"
    tags:  "lib"
    links: {}

  "stack-languages":
    todo: "todo - stack-lang from thesis, f1k"
    type: "code"
    tags:  "languages"
    links: {}

  grundat:
    type: "presentation"
    tags:  "teaching"
    links:
      github: "rasmuserik/rasmusjensen/grundat"

  "osd-javascript":
    todo: "todo"
    type: "presentation"
    tags:  "slides-tech-talks"
    links: {}

  "find-a-day":
    desc: "meteor calendar-oriented doodle-like app"
    type: "apps"
    tags:  "protoapps"
    links: {}

  "osd-html5":
    todo: "todo"
    type: "presentation"
    tags:  "slides-tech-talks"
    links: {}

  "onetwo360-client":
    online:
      "/360": "360-viewer"

    type: "apps"
    tags:  "widgets"
    links:
      github: "rasmuserik/onetwo360/360-viewer"
      online: "/360/demo.html"

  "berlincompiler-yolan":
    todo: "todo"
    type: "presentation"
    tags:  "slides-tech-talks"
    links: {}

  treelayout:
    desc: "Layout a tree datastructure as boxes - GUI-experiment"
    type: "apps"
    tags:  "demo"
    links: {}

  jsengines:
    todo: "todo"
    type: "presentation"
    tags:  "slides-tech-talks"
    links: {}

  "meteor-litcoffee":
    todo: "todo"
    type: "code"
    tags:  "oss-contrib"
    links: {}

  scores:
    build: "lilypond *.ly"
    type: "meta"
    tags:  "build"
    links:
      github: "rasmuserik/music"

  "rhino-e4x":
    todo: "todo"
    type: "code"
    tags:  "oss-contrib"
    links: {}

  massdrive:
    desc: "experiment with touch flying square"
    type: "apps"
    tags:  "protoapps"
    links: {}

  photos:
    todo: "by category"
    type: "meta"
    tags:  "TODO"
    links: {}

  indretning:
    todo:  "Duden skænk, Node væg, Wires, Hjørnehylder"
    type: "meta"
    tags:  "TODO"
    links: {}

  old:
    online:
      "/old": "app-old/public"

    type: "meta"
    tags:  "build"
    links:
      github: "rasmuserik/app-old"

  "yolan-server":
    server: "install -d build; cp dep/* build/; ./yolan server"
    online:
      yolan: ":1234"

    type: "meta"
    tags:  "build"
    links:
      github: "rasmuserik/yolan"

  jurapp:
    desc: "prototyping decision support for social workers"
    type: "apps"
    tags:  "protoapps"
    links: {}

  "yolan-old":
    type: "code"
    tags:  "languages"
    links:
      github: "rasmuserik/language-experiment"
      html5: "thesis"

  fototips:
    desc: "notes for taking photos"
    type: "writings"
    tags:  "notes"
    links:
      github: "rasmuserik/writings"

  "force-based-graph":
    desc: "simple implementation of force-based graph layout"
    type: "apps"
    tags:  "demo"
    links: {}

  "fractal-4d":
    desc: "visualisation of 4d fractal"
    type: "apps"
    tags:  "demo"
    links: {}

#{{{2 processing

for key, val of apps
  val.date ?= ""
  val.links ?= []
  val.tags = (val.tags || "").split ", "

#{{{1 generate index.html
#{{{2 style
style =
  #{{{3 basic style
  body:
    margin: 0
    padding: 0
    fontFamily: "Ubuntu, sans-serif"

  div:
    margin: "0"
    padding: "0"

  #{{{3 header bar
  h1:
    margin: "20px 0 20px 0"
    textAlign: "center"

  "h1 img":
    width: 50
    height: 50
    verticalAlign: "middle"
    margin: "0 20px 0 0"

  "h1 span":
    margin: 0
    padding: 0
    verticalAlign: "middle"
    display: "inline-block"
    fontWeight: "normal"
    fontSize: 40
    textAlign: "center"

  "hr":
    width: "80%"
    marginBottom: "40px"


  ".items":
    textAlign: "center"
    fontSize: "24px"
    wordSpacing: "24px"

  ".items span":
    whiteSpace: "nowrap"
    wordSpacing: "0px"

  #{{{3 entries
  ".entries":
    textAlign: "center"
    wordSpacing: 0

  ".entry":
    display: "inline-block"
    verticalAlign: "top"
    marginBottom: 60
    marginLeft: 20
    marginRight: 20
    wordSpacing: 0

  ".icon":
    width: 100
    height: 100
    margin: "5px 29px 5px 29px"
    verticalAlign: "top"
    borderRadius: 100
    border: "1px solid #888"
    #boxShadow: "1px 1px 3px rgba(0,0,0,1)"

  ".meta":
    verticalAlign: "top"
    textAlign: "left"
    display: "inline-block"
    width: 300
    margin: "0 -10px 0 -10px"

  ".date":
    padding: 0
    margin: 0
    float: "right"
    verticalAlign: "top"
    textAlign: "right"
    display: "inline-block"
    marginBottom: 0

  ".date div":
    marginBottom: 0
  ".monthdate":
    color: "#555"
    fontSize: 16
    clear: "none"
    margin: 0
  ".year":
    color: "#aaa"
    fontSize: 24
    clear: "none"
    margin: 0

  ".meta h2":
    margin: 0
    padding: 0
    clear: "none"
    fontSize: 24
    fontWeight: "normal"
    marginBottom: 4

  ".tags":
    lineHeight: "27px"
    marginBottom: 8

  ".tags span":
    whiteSpace: "nowrap"
    padding: "0px 1px 2px 1px"
    borderRadius: "2px"
    color: "#444"
    backgroundColor: "#e8e8e8"
    border: "1px solid #d8d8d8"
 
  ".desc":
    marginBottom: 6

  ".links":
    wordSpacing: "8px"

  ".links .linkbox":
    wordSpacing: "0px"
    display: "inline-block"
    textAlign: "center"
    minWidth: 36
    height: 35
    verticalAlign: "bottom"
    marginBottom: "5px"
    borderRadius: 40
    fontSize: "20px"
    fontWeight: "normal"
    textDecoration: "none"
    padding: "9px 4px 0px 4px"
    border: "2px solid"
    boxShadow: "2px 2px 6px rgba(0,0,0,0.3)"

  ".links .small":
    padding: "5px 4px 0px 4px"
    height: 39
    fontSize: 14
    fontWeight: "bold"

#{{{3 Convert to text
style = ("#{key}{#{jsonml2html.obj2style val}}" for key, val of style).join ""
style = "@font-face{font-family:Ubuntu; font-weight:400; src: url(/font/ubuntu-latin1.ttf) format(truetype);}" +
  "@font-face{font-family:Ubuntu; font-weight:400; src: url(/font/ubuntu-latin1.ttf) format(truetype);}" +
  style

#{{{2 entries
#{{{2 body

body = undefined
do ->
  items = []
  for item in "Apps,Visualisations,HTML5,Open Data,IT-consulting".split(",")
    items.push ["span", item]
    items.push " "

  #{{{3 month names
  months =
    "01": "January"
    "02": "February"
    "03": "March"
    "04": "April"
    "05": "May"
    "06": "June"
    "07": "July"
    "08": "August"
    "09": "September"
    "10": "October"
    "11": "November"
    "12": "December"
    "": ""

  #{{{3 link icon
  hashColor = require "hashcolor"

  linkIcon = (name, url) ->
    if -1 != name.indexOf "_"
      ["a.linkbox.small"
        style: color: hashColor.dark name
        href: url
      ["rawhtml", name.replace /_/g, "<br>"]]
    else
      ["a.linkbox"
        itemprop: "url"
        style: color: hashColor.dark name
        href: url
      name]


  #{{{3 tags
  genTags = (entry) ->
    result = []
    for tag in entry.tags
      result.push " "
      result.push ["span"
          itemprop: "keywords"
        tag]
    result

  #{{{3 create entries
  entries = []
  for id, entry of apps
    if entry.icon
      links = []
      for type, url of entry.links
        links.push linkIcon type, url
        links.push " "

      date = ["div.date", ""]
      monthday = months[entry.date.slice(5,7)]
      monthday += " " + +entry.date.slice(8,10) if monthday && entry.date.slice(8,10)
      # only show year
      # date.push ["div.monthday", monthday] if monthday
      date.push ["div.year", entry.date.slice(0,4)] if entry.date.slice(0,4)


      entries.push ["div.entry", {itemscope: "itemscope", itemtype: "http://schema.org/#{entry.kind || "CreativeWork"}"}
        ["img.icon", {itemprop: "image", src: "icons/#{entry.icon}"}]
        ["div.meta"
          date
          ["h2", {itemprop:"name", style:{verticalAlign:"top"}}, ["rawhtml",entry.name]]
          ["div.tags", ""].concat genTags(entry)
          ["div.desc", {itemprop:"description"}, ["rawhtml", entry.desc]]
          ["div.links", ""].concat links
        ]
      ]
      entries.push " "


  #{{{3 body
  body = ["body"
    ["h1"
      ["img", {src:"icons/solsort.png"}]
      " "
      ["span", "solsort.com ApS"]]
    ["div.items"].concat items
    ["hr"]
    ["div.entries"].concat entries
  ]


#{{{2 head
head = ["head"
  ["title", "solsort.com"]
  ["meta", {"http-equiv": "Content-Type", content: "text/html;charset=UTF-8"}]
  ["meta", {"http-equiv": "X-UA-Compatible", content: "IE=edge,chrome=1"}]
  ["meta"
    name: "viewport"
    content: "width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"]
  ["meta", {name: "format-detection", content: "telephone=no"}]
  ["style", ["rawhtml", style]]
]

#{{{2 html
html = "<!DOCTYPE html>" + jsonml2html.toString ["html", head, body]

console.log "writing index.html"
(require "fs").writeFile "index.html", html


# {{{1 import old list
###
require "js-yaml"
y = require "js-yaml"
data = require "../manager/content.yml"
arr = []
for cat, subcats of data
  for subcat, elem of subcats
    for id, item of elem
      item.id ?= id
      item.type = cat
      item.tags = [subcat].concat((item.tags || "").split ", ")
      item.links = {}
      if item.github
        if item.github.indexOf "/" == -1
          item.github = "rasmuserik/" + item.github
        item.links.github = item.github
        delete item.github
      if item.link
        item.links.html5 = item.link
        delete item.link
      if item.demo
        item.links.online = item.demo
        delete item.demo
      arr.push item
arr.sort (a,b) ->
  return if (a.date || "0")  > (b.date || "0") then -1 else 1

obj = {}
for item in arr
  id = item.id
  delete item.id
  obj[id] = item

console.log JSON.stringify obj
###
