define ['cs!models/StaticEntity'], (StaticEntity) ->

    class WallEntity extends StaticEntity

        template:
            type: 'static'
            width: 2.34
            height: 20

    return WallEntity