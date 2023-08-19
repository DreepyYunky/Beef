package beef
import sdl "vendor:sdl2"
import "Widgets/Text"
import "Widgets/Colors"
when ODIN_OS == .Windows {
	foreign import lib "SDL2.lib"
} else {
	foreign import lib "system:SDL2"
}

NewWindow :: proc(title: cstring, xAxis: i32, yAxis: i32) {
    window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN
    window := sdl.CreateWindow(
        title,
        sdl.WINDOWPOS_CENTERED,
        sdl.WINDOWPOS_CENTERED,
        xAxis,
        yAxis,
        window_flags,
    )
    renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)
    flag := true
    for flag {
        sdl.Delay(1000)
    }
    
}
main :: proc() {
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
    
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)

    assert(sdl_init == 0, sdl.GetErrorString())
}