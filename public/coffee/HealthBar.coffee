define ['jquery'], ($) ->

  class HealthBar

    healthHeight: 47
    totalHealth: 6

    constructor: (@canvas) ->
      @bar = $('#health-bar')
      @canvas.bind 'setHealth', @onSetHealth

    onSetHealth: (e, data) =>
      return unless data.health?
      missing = @totalHealth - data.health
      offset = missing * @healthHeight 
      @bar.css 'background-position', "0 #{offset}px"

  return HealthBar