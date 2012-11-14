define ['cs!models/DynamicEntity', 'image!/img/character.png'], (DynamicEntity, spriteSheet) ->

    class Character extends DynamicEntity
        frame: 0
        currentAction: 'standRight'
        previousAction: 'standRight'

        # Hash which maps actions to their spritemap rows and cells
        actionMap:
            standRight:
                row: 0
                start: 0
                frames: 1
            standLeft:
                row: 0
                start: 1
                frames: 1
            runRight:
                row: 1
                start: 0
                frames: 7
            runLeft:
                row: 2
                start: 0
                frames: 7

        template:
            name: 'character'
            fixedRotation: true
            spriteSheet: true
            image: spriteSheet.src
            imageOffsetX: -.45
            imageOffsetY: -.65
            width: 1.5
            height: 1.65
            spriteWidth: 64
            spriteHeight: 64
            spriteX: 0
            spriteY: 0

        onTick: =>
            @speed = @entity._body.m_linearVelocity.x
            # Determines the action method to run for updating the sprite
            actionMethod = 'onTick' + @currentAction[0].toUpperCase() + @currentAction[1..-1]
            # Update the sprite according to the actionMethod
            @[actionMethod].apply @

        onTickRunRight: =>
            @frame = @frame + @frameAdvanceSpeedX()
            x = @actionMap.runRight.start + Math.floor(@frame) % @actionMap.runRight.frames
            y = @actionMap.runRight.row
            @entity.sprite x, y
            @setAction 'standRight' if @speed is 0

        onTickRunLeft: =>
            @frame = @frame + @frameAdvanceSpeedX()
            x = @actionMap.runRight.start + Math.floor(@frame) % @actionMap.runRight.frames
            y = @actionMap.runLeft.row
            @entity.sprite x, y
            @setAction 'standLeft' if @speed is 0

        onTickStandRight: =>
            x = @actionMap.standRight.start
            y = @actionMap.standRight.row
            @entity.sprite x, y

        onTickStandLeft: =>
            x = @actionMap.standLeft.start
            y = @actionMap.standLeft.row
            @entity.sprite x, y

        setAction: (action) =>
            if action is @currentAction then return
            @previousAction = @currentAction
            @currentAction = action
            @frame = 0

        frameAdvanceSpeedX: =>
            # Determine amount to add to frame based on movement speed
            frameAdvance = Math.abs(@speed) / @maxVelocityX
            frameAdvance = Math.max frameAdvance, .25
            frameAdvance = Math.min frameAdvance, 1

    return Character