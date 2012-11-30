define ['cs!models/DynamicEntity', 'image!/img/level-asset-box.png'], (DynamicEntity, image) ->

    class BoxEntity extends DynamicEntity

        template:
            width: 1.25
            height: 1.25
            spriteSheet: true
            spriteWidth: 40
            spriteHeight: 40
            image: image.src
            imageOffsetX: -.3
            imageOffsetY: -.3
            density: .7

    return BoxEntity