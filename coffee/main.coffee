window.addEventListener "load", (e)=>
  window.removeEventListener("load", arguments.callee, false)

  if(typeof(webkitAudioContext)!="undefined")
    audioctx = new webkitAudioContext()
  else if(typeof(AudioContext)!="undefined")
    audioctx = new AudioContext()
   
  play=0
  osc = audioctx.createOscillator()
  gain = audioctx.createGainNode()
  osc.connect(gain)
  gain.connect(audioctx.destination)
   
  Setup = ()->
    if(play == 0)
      osc.noteOn(0)
      play = 1
   
    osc.type = 2
    gain.gain.value = 1
    window.addEventListener 'devicemotion', (event)->
      gv = event.accelerationIncludingGravity
      x = Math.abs gv.x
      y = Math.abs gv.y
      z = Math.abs gv.z
      osc.frequency.value = 440 / 9.8 * (x + y + z)
      
  if window.navigator.standalone
    Setup()
  else
    document.getElementById("info").addEventListener "touchstart", Setup

