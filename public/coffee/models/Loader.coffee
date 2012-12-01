define [
  'jquery'
  'boxbox'
  'cs!models/GroundEntity'
  'cs!models/PlayableCharacter'
  'cs!models/DoorEntity'
  'cs!models/PlateEntity'
  'cs!models/BoxEntity'
  'cs!models/PlatformEntity'
  'json!/data/level01.json'], ($, boxbox, GroundEntity, PlayableCharacter, DoorEntity, PlateEntity, BoxEntity, PlatformEntity, Level) ->

  class Loader

    @currentLevel = 0

    constructor: ->
      @loadLevel Level
      $('#gamescape').on 'requestLevel', (e) =>
        @loadLevel @currentLevelRequest
      # @currentLevel = 1

    loadLevel: (levelRequested) =>

      # if (JSON.stringify(grounds.length) or JSON.stringify(doors.length) or JSON.stringify(plates.length)) and @currentLevel > 0
      #   do grounds.destroy
      #   do doors.destroy
      #   do plates.destroy

      $canvas = $ '#gamescape'
      canvas = $canvas.get 0

      world = boxbox.createWorld canvas, levelRequested.World

      grounds = (new GroundEntity world, options).register() for options in levelRequested.GroundEntity

      doors = (new DoorEntity world, options).register() for options in levelRequested.DoorEntity

      plates = (new PlateEntity world, options).register() for options in levelRequested.PlateEntity

      boxes = (new BoxEntity world, options).register() for options in levelRequested.BoxEntity

      platforms = (new PlatformEntity world, options).register() for options in levelRequested.PlatformEntity

      player = new PlayableCharacter world, levelRequested.PlayableCharacter

      player.register()

      if !@currentLevel
        @currentLevel = 1
      else
        @currentLevel = @currentLevel + 1

    nextLevel: (levelRequested) =>
      if levelRequested < 4 or levelRequested > 0
        require ['jquery',"json!/data/level0#{levelRequested}.json"], ($, newLevel) =>
          @currentLevelRequest = newLevel
      return

  return Loader