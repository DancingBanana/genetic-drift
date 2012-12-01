define ['cs!models/StaticEntity', 'image!/img/level-asset-door.png'], (StaticEntity, image) ->

    class DoorEntity extends StaticEntity

        isOpen: false
        engaged: false

        template:
            type: 'static'
            name: 'door'
            height: 3
            width: .3
            image: image.src
            imageOffsetX: -.1
            fixedRotation: true
            spriteSheet: true
            spriteWidth: 10
            density: 100 # Make it impossible to move

        constructor: (@world, @overrides = {}) ->
            @template.spriteHeight = @overrides.height * @world.scale() * .95
            @template.imageOffsetY = -1 * @overrides.height * .25
            super @world, @overrides

        register: =>
            super()
            if @entity.$orientation is 'horizontal' then @entity.rotation 90
            @originalPosition = @entity.position()
            eventNameBase = @entity._name
            @canvas.bind(eventNameBase + '.open', @onOpen)
            @canvas.bind(eventNameBase + '.close', @onClose)
            @canvas.bind(eventNameBase + '.disengage', @onDisengage)
            @

        onOpen: =>
            if @engaged then return
            @engaged = true
            @canvas.trigger 'door.sound' unless @isOpen
            @isOpen = true
            do @jostleNearby
            @entity.position {x:9999, y:9999}
            console.log @entity.position()

        onClose: =>
            if @engaged then return
            @canvas.trigger 'door.sound' unless not @isOpen
            @entity.position @originalPosition
            @isOpen = false

        onDisengage: =>
            @engaged = false

        jostleNearby: =>
            pos = @entity.position()
            x1 = pos.x - @overrides.width
            x2 = pos.x + @overrides.width
            y1 = pos.y - .3
            y2 = pos.y + .3
            targets = @world.find x1, y1, x2, y2
            target.applyImpulse(1, 0, 1) for target in targets

    return DoorEntity
