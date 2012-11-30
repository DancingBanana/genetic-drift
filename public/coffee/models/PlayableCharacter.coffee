define ['cs!models/Character'], (Character) ->

    class PlayableCharacter extends Character

        planted: false

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
                @entity.setForce 'movement', 8, 270
                if @currentAction.indexOf('jump') is -1 then @setAction 'runLeft'
                return false

            # Move right
            if e.keyCode is 39 # or e.keyCode is 68
                if @actionLock then return
                @entity.friction 0
                @entity.setForce 'movement', 8, 90
                if @currentAction.indexOf('jump') is -1 then @setAction 'runRight'
                return false

            # Clone Action
            if e.keyCode is 67
                if @actionLock then return
                @setAction 'clone'
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

    return PlayableCharacter