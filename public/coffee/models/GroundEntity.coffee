define ['cs!models/StaticEntity', 'image!/img/level-asset-ground.png'], (StaticEntity, image) ->

    class GroundEntity extends StaticEntity
        template:
            name: 'ground'
            type: 'static'
            spriteSheet: true
            spriteHeight: 20
            image: image.src
            imageOffsetY: -.15
            height: .6

        constructor: (@world, @overrides = {}) ->
            super(@world, @overrides)
            @template.spriteWidth = @overrides.width * @world.scale() * .95
            @template.imageOffsetX = -1 * @overrides.width * .25

    return GroundEntity