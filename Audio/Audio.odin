// Audio package for Beef

// This library is powered by SDL2's Mixer extension. It uses the same license as Beef.
package audio
import sdl "vendor:sdl2"
import mix "vendor:sdl2/mixer"
import "core:fmt"

sdl_audio_init := sdl.Init(sdl.INIT_AUDIO)

PlayAudio :: proc(frequency: i32, channels: i32, chunksize: i32)
{
    
}

main :: proc()
{
    def_frequency : i32 = 44100
    open := mix.OpenAudio(def_frequency, mix.DEFAULT_FORMAT, 4, 2)
    if open < 0 do fmt.println("ERROR: FAILED TO INITIALIZE SDL_MIXER")
    open = mix.AllocateChannels(4)
    
}