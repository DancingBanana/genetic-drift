define ['cs!models/StaticEntity', 'image!/img/level-asset-platform-medium.png'], (StaticEntity, image) ->

    class PlatformEntity extends StaticEntity

        template:
            type: 'static'
            name: 'platform'
            height: .2
            width: 3.2
            image: image.src
            imageOffsetX: -.8
            imageOffsetY: -.05

    return PlatformEntity