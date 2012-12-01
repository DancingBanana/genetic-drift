define ['cs!models/StaticEntity', 'image!/img/level-asset-door.png'], (StaticEntity, image) ->

    class DoorEntity extends StaticEntity

        isOpen: false

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

        onOpen: =>
            @canvas.trigger 'door.sound' unless @isOpen
            @isOpen = true
            @entity.position {x:9999, y:9999}

        onClose: =>
            @canvas.trigger 'door.sound' unless not @isOpen
            @entity.position @originalPosition
            @isOpen = false

    return DoorEntity
