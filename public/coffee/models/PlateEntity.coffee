define ['cs!models/StaticEntity', 'image!/img/level-asset-pressure-plate.png'], (StaticEntity, image) ->

    class PlateEntity extends StaticEntity

        active: false

        template:
            active: false
            height: .4
            width: 1.7
            image: image.src
            spriteSheet: true
            spriteHeight: 9
            spriteWidth: 53
            imageOffsetX: -.4
            imageOffsetY: -.05

        onTick: =>
            if @isActivated()
                @active = true
                @canvas.trigger @entity.$target + '.open'
                @entity.sprite 1, 0
            else
                if @active
                    @canvas.trigger @entity.$target + '.disengage'
                    @active = false
                @canvas.trigger @entity.$target + '.close'
                @entity.sprite 0, 0

        isActivated: =>
            pos = @entity.position()
            width = @entity._ops.width
            height = @entity._ops.height
            x1 = pos.x - width / 2
            y2 = pos.y - height / 2
            x2 = pos.x + width / 2
            y1 = y2 - height
            return @world.find(x1, y1, x2, y2).length

    return PlateEntity