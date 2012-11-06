define ['cs!models/Entity'], (Entity) ->

    class StaticEntity extends Entity
        template:
            type: 'static'

    return StaticEntity