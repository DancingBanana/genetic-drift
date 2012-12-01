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
  'cs!HealthBar'
  'json!/data/level01.json'], ($, boxbox, GroundEntity, PlayableCharacter, DoorEntity, PlateEntity, BoxEntity, PlatformEntity, GoalEntity, WallEntity, SoundHelper, HealthBar, level) ->

  class Loader

    currentLevel: 1

    constructor: ->
      @currentLevel = 1
      $canvas = $ '#gamescape'
      @canvas = $canvas.get 0
      @sound = new SoundHelper $canvas
      @health = new HealthBar $canvas
      @loadLevel level
      $('#gamescape').on 'nextLevel', (e) =>
        @nextLevel()

    loadLevel: (levelRequested) =>

      # Clear last level's data
      if @deletables?.length then deletable.destroy() for deletable in @deletables
      if not @world? then @world = boxbox.createWorld @canvas, levelRequested.World

      # Set background image
      do $(@canvas).removeClass
      $(@canvas).addClass "level#{@currentLevel}"

      if levelRequested.WallEntity?
          @deletables = ((new WallEntity @world, options).register() for options in levelRequested.WallEntity)
      if levelRequested.GroundEntity?
          @deletables.push ((new GroundEntity @world, options).register() for options in levelRequested.GroundEntity)...
      if levelRequested.DoorEntity?
          @deletables.push ((new DoorEntity @world, options).register() for options in levelRequested.DoorEntity)...
      if levelRequested.PlateEntity?
          @deletables.push ((new PlateEntity @world, options).register() for options in levelRequested.PlateEntity)...
      if levelRequested.BoxEntity?
          @deletables.push ((new BoxEntity @world, options).register() for options in levelRequested.BoxEntity)...
      if levelRequested.PlatformEntity?
          @deletables.push ((new PlatformEntity @world, options).register() for options in levelRequested.PlatformEntity)...

      # Delete clones from last level
      if @world.$cloneList? then do clone.destroy for clone in @world.$cloneList

      goal = new GoalEntity @world, levelRequested.GoalEntity
      @deletables.push goal.register()

      if not @player?
          @player = new PlayableCharacter @world, levelRequested.PlayableCharacter
          @player.register()

      @player.entity.position {x:levelRequested.PlayableCharacter.x, y:levelRequested.PlayableCharacter.y}

    nextLevel: =>
      @currentLevel = @currentLevel + 1
      if @currentLevel < 3
        require ["json!/data/level0#{@currentLevel}.json"], (newLevel) =>
          @loadLevel newLevel
      else
        $cont = $ '.game-over-container'
        $cont.addClass 'is-active'
        $cont.on 'click', () ->
          $cont.removeClass 'is-active'
          window.location = '/'
      return

  return Loader