define ['cs!models/Character'], (Character) ->

    class PlayableCharacter extends Character

        planted: false

        onKeydown: (e) =>

            pos = @entity.position()

            if e.keyCode is 32 # and standingOn.length
                @entity.applyImpulse 20, 0, -1
                return false

            if e.keyCode is 37
                @entity.friction 0
                @entity.setForce 'movement', 8, 270
                return false

            if e.keyCode is 39
                @entity.friction 0
                @entity.setForce 'movement', 8, 90
                return false

        onKeyup: (e) =>

            if e.keyCode is 37 or e.keyCode is 39
                @entity.clearForce 'movement'
                @entity.friction 3
                return false

    return PlayableCharacter