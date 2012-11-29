define [
  'cs!models/GroundEntity'
  'cs!models/PlayableCharacter'
  'cs!models/DoorEntity'
  'json!/data/level01.json'], (GroundEntity, PlayableCharacter, DoorEntity, Level) ->

  class Loader
    $canvas = $ '#gamescape'
    canvas = $canvas.get 0
    canvas.width = document.width
    canvas.height = document.height

    # Grab the first index in the array and reassign it to Level

    # console.log 'Level', Level if console.log?

    world = boxbox.createWorld canvas, Level.World

    grounds = (new GroundEntity world, options).register() for options in Level.GroundEntity

    doors = (new DoorEntity world, options).register() for options in Level.DoorEntity

    player = new PlayableCharacter world, Level.PlayableCharacter

    player.register()

  return Loader