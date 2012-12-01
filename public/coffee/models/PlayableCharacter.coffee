define ['cs!models/Character', 'cs!models/CloneCharacter'], (Character, CloneCharacter) ->

    class PlayableCharacter extends Character

        planted: false
        health: 6

        constructor: (@world, @overrides = {}) ->
            @overrides.name = 'player'
            super @world, @overrides

        onKeydown: (e) =>

            @speed = @entity._body.m_linearVelocity.x

            # Jump
            if e.keyCode is 32
                if @actionLock then return
                return unless @jumpable
                @entity.applyImpulse 12, 0, -1
                @setAction (if @speed > 0 or @currentAction.indexOf('Right') isnt -1 then 'jumpRight' else 'jumpLeft')
                return false
            
            # Move Left
            if e.keyCode is 37 # or e.keyCode is 65
                if @actionLock then return
                @entity.friction 0
                @entity.setForce 'movement', 12, 270
                if @jumping then return
                if not @currentAction.match /jump/i then @setAction 'runLeft'
                return false

            # Move right
            if e.keyCode is 39 # or e.keyCode is 68
                if @actionLock then return
                @entity.friction 0
                @entity.setForce 'movement', 12, 90
                if @jumping then return
                if not @currentAction.match /jump/i then @setAction 'runRight'
                return false

            # Clone Action
            if e.keyCode is 67
                if @actionLock then return
                return unless @health > 1
                @setAction 'clone'
                @canvas.trigger 'clone.sound'
                return false

            # Attack
            if e.keyCode is 86
                if @actionLock then return
                @setAction (if @speed > 0 or @currentAction.indexOf('Right') isnt -1 then 'attackRight' else 'attackLeft')
                return false

        onKeyup: (e) =>

            if e.keyCode is 37 or e.keyCode is 39
                @entity.clearForce 'movement'
                @entity.friction 3
                return false

        createClone: =>
            pos = @entity.position()
            x = pos.x
            if @previousAction.match /right/i then x = x + .1
            clone = new CloneCharacter @world,
                x: x
                y: pos.y
            clone.register()

    return PlayableCharacter