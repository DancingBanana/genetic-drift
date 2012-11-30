define [
    'jquery'
    'boxbox'
    'cs!models/GroundEntity'
    'cs!models/PlayableCharacter',
    'cs!models/Loader'], ($, boxbox, GroundEntity, PlayableCharacter, Loader) ->

    game = new Loader
    # game.loadLevel 2
    game.nextLevel 2
    game.nextLevel 3

