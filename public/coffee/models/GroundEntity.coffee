define ['jquery', 'cs!models/StaticEntity'], ($, StaticEntity) ->

    class GroundEntity extends StaticEntity
        template:
            name: 'ground'
            type: 'static'
            height: .2
            color: 'green'
            borderColor: 'rgba(0, 100, 0, .5)'
            borderWidth: 3

    return GroundEntity