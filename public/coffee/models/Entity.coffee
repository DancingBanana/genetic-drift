define [], () ->

    class Entity
        constructor: (@world, @overrides = {}) ->

        entity: {}

        template: {}

        register: =>
            @entity = @world.createEntity(@template, @overrides)
            @

    return Entity