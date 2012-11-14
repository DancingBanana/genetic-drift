define ['cs!models/DynamicEntity', 'image!/img/character.png'], (DynamicEntity, spriteSheet) ->

    class Character extends DynamicEntity
        frame: 0
        frameMod: 7

        template:
            name: 'character'
            fixedRotation: true
            spriteSheet: true
            image: spriteSheet.src
            imageOffsetX: -.45
            imageOffsetY: -.65
            width: 1.5
            height: 1.65
            spriteWidth: 64
            spriteHeight: 64
            spriteX: 0
            spriteY: 0

        onTick: =>
            @frame++
            @frame = @frame % @frameMod
            @entity.sprite @frame, 0

    return Character