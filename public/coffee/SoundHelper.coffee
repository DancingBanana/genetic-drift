define ['json!/data/sound.json'], (soundData) ->

    class SoundHelper

        constructor: (@canvas) ->
            sounds = (@registerSound sound for sound in soundData)

        playSound: (e) =>
            name = e.type
            el = $("##{name}Sound")[0]
            el.play() unless !el.paused

        stopSound: (e) =>
            name = e.type
            el = $("##{name}Sound")[0]
            el.pause() unless el.paused

        registerSound: (sound) =>
            soundPath = "/sound/#{sound.src}"
            id = "#{sound.name}Sound"
            doLoop = (if sound.loop then 'loop' else '')
            audioEl = $ "<audio src=\"#{soundPath}\" id=\"#{id}\" #{doLoop}>"
            audioEl.load()
            $('body').append audioEl
            @canvas.bind "#{sound.name}.sound", @playSound
            @canvas.bind "#{sound.name}.soundOff", @stopSound

    return SoundHelper