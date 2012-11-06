define [
    'jquery'
    'boxbox'
    'cs!models/GroundEntity'
    'cs!models/Character' ], ($, boxbox, GroundEntity, Character) ->

    $canvas = $ '#gamescape'
    canvas = $canvas.get 0
    world = boxbox.createWorld canvas, { collisionOutlines: true, scale:32, tickFrequency: 100 }

    grounds = (new GroundEntity world, options).register() for options in [
        { width: 20, x: 10, y: 13.22 }
        { width: 6, x: 3, y: 5 }
        { width: 2, x: 9, y: 6.5 }
        { width: 2, x: 11, y: 8 }
        { width: 2, x: 13, y: 9.5 }
        { width: 2, x: 15, y: 11 }
        { width: 2, x: 13, y: 12.5 }
        { width: 8, x: 16, y: 5 } ]

    character = (new Character world, { x: 2, y: 10 } ).register()

    player = world.createEntity
        name: 'player'
        height: .4
        width: .4
        x: 18
        y: 10
        shape: 'square'
        color: 'blue'
        maxVelocityX: 4

    player.onKeydown (e) ->

        return if @_destroyed

        pos = @position()
        allUnderMe = world.find pos.x - .08, pos.y + .1, pos.x + .09, pos.y + .105

        standingOn = (obj for obj in allUnderMe when obj isnt player)

        if e.keyCode is 32 and standingOn.length
            @applyImpulse 2
            return false

        if e.keyCode is 37
            @setForce 'movement', 8, 270
            @friction .1
            return false

        if e.keyCode is 39
            @setForce 'movement', 8, 90
            @friction .1
            return false

    player.onKeyup (e) ->

        return if @_destroyed

        if e.keyCode is 37 or e.keyCode is 39
            @clearForce 'movement'
            @friction 3
            return false

