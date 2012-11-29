define [
  'jquery'
  'boxbox'
  'cs!models/GroundEntity'
  'cs!models/PlayableCharacter'
  'cs!models/DoorEntity'
  'cs!models/PlateEntity'
  'json!/data/level01.json'], ($, boxbox, GroundEntity, PlayableCharacter, DoorEntity, PlateEntity, Level) ->

  class Loader
    $canvas = $ '#gamescape'
    canvas = $canvas.get 0

    # Grab the first index in the array and reassign it to Level

    # console.log 'Level', Level if console.log?

    world = boxbox.createWorld canvas, Level.World

    grounds = (new GroundEntity world, options).register() for options in Level.GroundEntity

    doors = (new DoorEntity world, options).register() for options in Level.DoorEntity

    plates = (new PlateEntity world, options).register() for options in Level.PlateEntity

    player = new PlayableCharacter world, Level.PlayableCharacter

    player.register()

  return Loader