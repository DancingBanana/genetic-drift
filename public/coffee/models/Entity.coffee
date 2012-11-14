define [], () ->

    class Entity
        maxVelocityX: 0

        constructor: (@world, @overrides = {}) ->
            @maxVelocityX = @overrides['maxVelocityX'] if @overrides['maxVelocityX']

        entity: {}

        template: {}

        register: =>
            @entity = @world.createEntity(@template, @overrides)
            # Register the class's handlers with the entity, if defined
            @entity.onTick @onTick if typeof @onTick is 'function'
            @entity.onKeydown @onKeydown if typeof @onKeydown is 'function'
            @entity.onKeyup @onKeyup if typeof @onKeyup is 'function'
            # Return this for chaining
            @

    return Entity