define ['cs!models/DynamicEntity', 'image!/img/character.png'], (DynamicEntity, spriteSheet) ->

    class Character extends DynamicEntity
        frame: 0
        currentAction: 'standRight'
        previousAction: 'standRight'
        jumpable: true

        damageBox:
            x: .25
            y: .5

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
            attackRight:
                row: 4
                start: 0
                frames: 1
            attackLeft:
                row: 4
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
            jumpRight:
                row: 3
                start: 1
                frames: 3
            jumpLeft:
                row: 3
                start: 5
                frames: 3

        template:
            name: 'character'
            fixedRotation: true
            spriteSheet: true
            image: spriteSheet.src
            imageOffsetX: -.45
            imageOffsetY: -.75
            width: .75
            height: 1.45
            spriteWidth: 64
            spriteHeight: 64
            restitution: 0
            spriteX: 0
            spriteY: 0
            maxVelocityX: 6
            maxVelocityY: 8

        onTick: =>
            @speed = @entity._body.m_linearVelocity.x
            @speedY = @entity._body.m_linearVelocity.y
            # Determines the action method to run for updating the sprite
            actionMethod = 'onTick' + @currentAction[0].toUpperCase() + @currentAction[1..-1]
            @checkJumpability()
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

        onTickJumpRight: =>
            frameAdvance = 0 if @speedY < 0
            frameAdvance = 2 if @speedY > 0
            frameAdvance = 1 if Math.abs(@speedY) < .5
            x = @actionMap.jumpRight.start + frameAdvance
            y = @actionMap.jumpRight.row
            @entity.sprite x, y
            @setAction (if @speedY is 0 then (if @speed isnt 0 then 'runRight' else 'standRight') else 'jumpRight')

        onTickJumpLeft: =>
            frameAdvance = 0 if @speedY < 0
            frameAdvance = 2 if @speedY > 0
            frameAdvance = 1 if Math.abs(@speedY) < .5
            x = @actionMap.jumpLeft.start + frameAdvance
            y = @actionMap.jumpLeft.row
            @entity.sprite x, y
            @setAction (if @speedY is 0 then (if @speed isnt 0 then 'runLeft' else 'standLeft') else 'jumpLeft')

        onTickAttackRight: =>
            target = @findTargets('right')
            target[0].$wrapper.destroy() if target.length
            x = @actionMap.attackRight.start
            y = @actionMap.attackRight.row
            @entity.sprite x, y
            @setAction @previousAction

        onTickAttackLeft: =>
            target = @findTargets('left')
            target[0].$wrapper.destroy() if target.length
            x = @actionMap.attackLeft.start
            y = @actionMap.attackLeft.row
            @entity.sprite x, y
            @setAction @previousAction

        checkJumpability: =>
            speedY = @entity._body.m_linearVelocity.y
            @jumpable = speedY is 0

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

        findTargets: (direction) =>
            pos = @entity.position()
            x1 = x2 = 0
            if direction is 'left'
                x1 = pos.x - @damageBox.x
                x2 = pos.x
            else
                x1 = pos.x + @template.width
                x2 = x1 + @damageBox.x
            y1 = pos.y
            y2 = y1 + @damageBox.y
            potentials = @world.find x1, y1, x2, y2
            potentials = potentials.filter (target) -> target._name is 'character'
            potentials

    return Character