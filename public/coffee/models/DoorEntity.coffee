define ['cs!models/StaticEntity'], (StaticEntity) ->

    class DoorEntity extends StaticEntity

        template:
            name: 'door'
            height: 3
            width: .2
            color: 'red'
            fixedRotation: true
            density: 100 # Make it impossible to move

        register: =>
            super()
            @originalPosition = @entity.position()
            eventNameBase = @entity._name
            @canvas.bind(eventNameBase + '.open', @onOpen)
            @canvas.bind(eventNameBase + '.close', @onClose)

        onOpen: =>
            @entity.position {x:9999, y:9999}

        onClose: =>
            @entity.position @originalPosition

    return DoorEntity
