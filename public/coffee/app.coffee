define [
    'jquery'
    'boxbox'
    'cs!models/Loader'], ($, boxbox, Loader) ->

    game = new Loader

    _introduction = () ->
      $cont = $ '.intro-container'
      $btn = $ '.next-intro-btn'
      $cont.show() if $cont.is(':visible') is false
      $btn.show() if $btn.is(':visible') is false
      $btn.removeClass 'play-now'
      $cont.css {
        "backgroundImage": "url('img/intro-screen-01.jpg')"
      }
      cnt = 0
      $btn.on 'click', (e) ->
        do e.preventDefault
        cnt = cnt + 1
        switch cnt
          when 1
            $cont.css {
              "backgroundImage": "url('img/intro-screen-02.jpg')"
            }
            $btn.css {
              "top": "370px"
              "left": "460px"
            }
          when 2
            $cont.css {
              "backgroundImage": "url('img/intro-screen-03.jpg')"
            }
            $btn.addClass 'play-now'
            $btn.attr 'style', ''

        if cnt > 2
          do $(this).off
          cnt = 'done'
          do $('.intro-container').hide
          do $(this).hide

    _credits = () ->
      $cont = $ '.credits-container'
      $cont.addClass 'is-active'


    do _introduction

    $info = $ '.btn.info'
    $credits = $ '.btn.credits'

    $info.on 'click', () ->
      do _introduction if $('.intro-container').is(':hidden') and $('.next-intro-btn').is(':hidden')

    $credits.on 'click', () ->
      if $('.credits-container').is(':hidden')
        do _credits
      else
        do $('.credits-container').removeClass 'is-active'
