define ['jquery'], ($) ->

    class Entity
        maxVelocityX: 1

        constructor: (@world, @overrides = {}) ->
            @maxVelocityX = if @overrides['maxVelocityX'] then @overrides['maxVelocityX'] else @template['maxVelocityX']
            @maxVelocityY = if @overrides['maxVelocityY'] then @overrides['maxVelocityY'] else @template['maxVelocityY']

            # Pass down a reference to this wrapper to the entity, for easy
            # reference
            @overrides['$wrapper'] = @

        entity: {}

        template: {}

        register: =>
            @canvas = $ @world._canvas
            @entity = @world.createEntity(@template, @overrides)
            # Register the class's handlers with the entity, if defined
            @entity.onTick @onTick if typeof @onTick is 'function'
            @entity.onKeydown @onKeydown if typeof @onKeydown is 'function'
            @entity.onKeyup @onKeyup if typeof @onKeyup is 'function'
            @entity.onImpact @onImpact if typeof @onImpact is 'function'
            # Return this for chaining
            @

        destroy: =>
            @entity.destroy()

    return Entity