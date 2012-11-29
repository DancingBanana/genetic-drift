define ['cs!models/StaticEntity'], (StaticEntity) ->

    class PlateEntity extends StaticEntity

        template:
            active: false
            height: .1

        onTick: =>
            if @isActivated()
                @canvas.trigger @entity.$target + '.open'
            else
                @canvas.trigger @entity.$target + '.close'

        isActivated: =>
            pos = @entity.position()
            width = @entity._ops.width
            height = @entity._ops.height
            x1 = pos.x - width / 2
            y2 = pos.y - height / 2 - .1
            x2 = pos.x + width / 2
            y1 = y2 - height
            return @world.find(x1, y1, x2, y2).length

    return PlateEntity