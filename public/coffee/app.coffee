define [
    'jquery'
    'boxbox'
    'cs!models/GroundEntity'
    'cs!models/PlayableCharacter',
    'cs!models/Loader'], ($, boxbox, GroundEntity, PlayableCharacter, Loader) ->

    game = new Loader

    _introduction = () ->
      $btn = $ '.next-intro-btn'
      cnt = 0
      $btn.on 'click', (e) ->
        do e.preventDefault
        console.log 'cnt', cnt if console.log?
        if cnt >= 2
          do $(this).off
          cnt = 'done'
          do $('.intro-container').remove
          do $(this).remove
        cnt = cnt + 1

    do _introduction