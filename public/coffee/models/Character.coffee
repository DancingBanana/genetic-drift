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
            # Determines the action method to run for updating the sprite
            actionMethod = 'onTick' + @currentAction[0].toUpperCase() + @currentAction[1..-1]
            # Update the sprite according to the actionMethod
            @[actionMethod].apply @

        onTickRunRight: =>
            @frame = ++@frame % @actionMap.runRight.frames
            x = @actionMap.runRight.start + @frame
            y = @actionMap.runRight.row
            @entity.sprite x, y
            @setAction 'standRight' if @entity._body.m_linearVelocity.x is 0

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

    return Character