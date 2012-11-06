define [], () ->

    class Entity
        constructor: (@world, @overrides) ->

        template: {}

        register: =>
            @world.createEntity(@template, @overrides)
            @

    return Entity