define ['cs!models/Character', 'image!/img/character-clone.png'], (Character, spriteSheet) ->

    class CloneCharacter extends Character

        constructor: (@world, @overrides = {}) ->
            @template.image = spriteSheet.src
            super @world, @overrides

        onTick: =>
            value = Math.round (Math.random() * 100)
            if value is 5
                @setAction (if @currentAction is 'standRight' then 'standLeft' else 'standRight')
            super()

    return CloneCharacter