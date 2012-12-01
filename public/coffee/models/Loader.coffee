define [
  'jquery'
  'boxbox'
  'cs!models/GroundEntity'
  'cs!models/PlayableCharacter'
  'cs!models/DoorEntity'
  'cs!models/PlateEntity'
  'cs!models/BoxEntity'
  'cs!models/PlatformEntity'
  'cs!models/GoalEntity'
  'cs!models/WallEntity'
  'cs!SoundHelper'
  'json!/data/level01.json'], ($, boxbox, GroundEntity, PlayableCharacter, DoorEntity, PlateEntity, BoxEntity, PlatformEntity, GoalEntity, WallEntity, SoundHelper, Level) ->

  class Loader

    constructor: ->
      @nextLevel 1
      @currentLevel = 1
      $canvas = $ '#gamescape'
      @canvas = $canvas.get 0
      @sound = new SoundHelper $canvas
      @loadLevel Level
      $('#gamescape').on 'requestLevel', (e) =>
        @loadLevel @currentLevelRequest
      # @currentLevel = 1

    loadLevel: (levelRequested) =>

      @sound = new SoundHelper $canvas

      world = boxbox.createWorld @canvas, levelRequested.World

      if @currentLevel > 1
        do grounds.destroy for ground in grounds
        # return
        # @currentLevel = 'done'
        do doors.destroy for door in doors
        do plates.destroy for plate in plates
        do boxes.destroy for box in boxes
        do platforms.destroy for platform in platforms
        do goal.destroy
        do player.destroy

      world = boxbox.createWorld @canvas, levelRequested.World

      # Edge walls
      walls = (new WallEntity world, options).register() for options in levelRequested.WallEntity

      grounds = (new GroundEntity world, options).register() for options in levelRequested.GroundEntity

      doors = (new DoorEntity world, options).register() for options in levelRequested.DoorEntity

      plates = (new PlateEntity world, options).register() for options in levelRequested.PlateEntity

      boxes = (new BoxEntity world, options).register() for options in levelRequested.BoxEntity

      platforms = (new PlatformEntity world, options).register() for options in levelRequested.PlatformEntity

      goal = new GoalEntity world, levelRequested.GoalEntity
      goal.register()

      player = new PlayableCharacter world, levelRequested.PlayableCharacter

      player.register()

      # if !@currentLevel
      #   @currentLevel = 1
      # else
      @currentLevel = @currentLevel + 1

      $('#gamescape').on 'requestLevel', (e) =>
        $(this).off 'requestLevel'
        @nextLevel @currentLevel
        return
      return

    nextLevel: (levelRequested) =>
      if levelRequested < 4
        require ['jquery',"json!/data/level0#{levelRequested}.json"], ($, newLevel) =>
          @loadLevel newLevel
      return

  return Loader