package beef
import sdl "vendor:sdl2"
import "Widgets/."
/* when ODIN_OS == .Windows {
	foreign import lib "SDL2.lib"
} else {
	foreign import lib "system:SDL2"
}
 */
/* @private
end :: proc(event: ^sdl.Event) -> (exit: bool) {
    exit := false

    if event.type == sdl.EventType.QUIT || event.key.keysym.scancode == .ESCAPE {
        exit = true
    }
} */

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
    event: sdl.Event
    assert(window != nil, sdl.GetErrorString())
    quit: bool = false
    loop : for {
        if sdl.PollEvent(&event) {
            if event.type == sdl.EventType.QUIT do quit = true
        }
        sdl.RenderCopy(renderer, texture, nil, nil)
        sdl.RenderPresent(renderer);

        sdl.Delay(1000) // Delay for 1 second
    }
    @export renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)
    sdl.RenderCopy(renderer, texture, nil, nil)
    sdl.RenderPresent(renderer);
}
main :: proc() {
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)

    assert(sdl_init == 0, sdl.GetErrorString())

    
}