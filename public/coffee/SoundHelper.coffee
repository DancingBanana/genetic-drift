define ['json!/data/sound.json'], (soundData) ->

    class SoundHelper

        constructor: (@canvas) ->
            sounds = (@registerSound sound for sound in soundData)

        playSound: (e) =>
            name = e.type
            $("##{name}Sound")[0].play()

        registerSound: (sound) =>
            soundPath = "/sound/#{sound.src}"
            id = "#{sound.name}Sound"
            audioEl = $ "<audio src=\"#{soundPath}\" id=\"#{id}\">"
            audioEl.load()
            $('body').append audioEl
            @canvas.bind "#{sound.name}.sound", @playSound

    return SoundHelper