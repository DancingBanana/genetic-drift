define [
  'cs!models/GroundEntity'
  'cs!models/PlayableCharacter'
  'json!/data/level01.json'], (GroundEntity, PlayableCharacter, Level) ->

  class Loader
    $canvas = $ '#gamescape'
    canvas = $canvas.get 0

    # Grab the first index in the array and reassign it to Level

    # console.log 'Level', Level if console.log?

    world = boxbox.createWorld canvas, Level.World

    grounds = (new GroundEntity world, options).register() for options in Level.GroundEntity

    player = new PlayableCharacter world, Level.PlayableCharacter

    player.register()

  return Loader