define ['cs!models/Character', 'image!/img/character-clone.png'], (Character, spriteSheet) ->

    class CloneCharacter extends Character

        constructor: (@world, @overrides = {}) ->
            @template.image = spriteSheet.src
            super @world, @overrides

    return CloneCharacter