define ['cs!models/Character', 'image!/img/character-clone.png'], (Character, spriteSheet) ->

    class CloneCharacter extends Character

        constructor: (@world, @overrides = {}) ->
            @template.image = spriteSheet.src
            if not @world.$cloneList? then @world.$cloneList = []
            super @world, @overrides
            @world.$cloneList.push @

        onTick: =>
            value = Math.round (Math.random() * 100)
            if value is 5
                @setAction (if @currentAction is 'standRight' then 'standLeft' else 'standRight')
            super()

    return CloneCharacter