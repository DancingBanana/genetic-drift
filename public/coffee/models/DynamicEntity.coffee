define ['cs!models/Entity'], (Entity) ->

    class DynamicEntity extends Entity
        template:
            type: 'dynamic'

    return DynamicEntity