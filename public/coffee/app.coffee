define ['jquery', 'boxbox'], ($, boxbox) ->
    $canvas = $ '#gamescape'
    canvas = $canvas.get 0
    world = boxbox.createWorld canvas


    groundTemplate =
        name: 'ground'
        type: 'static'
        height: .2
        color: 'green'
        borderColor: 'rgba(0, 100, 0, .5)'
        borderWidth: 3


    world.createEntity groundTemplate,
        width: 20
        x: 10
        y: 13.22

    world.createEntity groundTemplate,
        width: 6
        x: 3
        y: 5

    world.createEntity groundTemplate,
        width: 2
        x: 9
        y: 6.5

    world.createEntity groundTemplate,
        width: 2
        x: 11
        y: 8

    world.createEntity groundTemplate,
        width: 2
        x: 13
        y: 9.5

    world.createEntity groundTemplate,
        width: 2
        x: 15
        y: 11

    world.createEntity groundTemplate,
        width: 2
        x: 13
        y: 12.5

    world.createEntity groundTemplate,
        width: 8
        x: 16
        y: 5


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

