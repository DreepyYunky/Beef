package beef
import sdl "vendor:sdl2"
import "Widgets/Text"
import "Widgets/Colors"
when ODIN_OS == .Windows {
	foreign import lib "SDL2.lib"
} else {
	foreign import lib "system:SDL2"
}

@private
end :: proc(event: ^sdl.Event) -> (exit: bool) {
    exit := false

    if event.type == sdl.EventType.QUIT || event.key.keysym.scancode == .ESCAPE {
        exit = true
    }
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
    event: sdl.Event
    assert(window != nil, sdl.GetErrorString())
    loop : for {
        if sdl.PollEvent(&event) {
            if event.type == sdl.Quit() do quit = true
        }
        sdl.RenderCopy(renderer, texture, nil, nil)
        sdl.RenderPresent(renderer);

        sdl.Delay(1000)
    }
}
main :: proc() {
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
    renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)

    assert(sdl_init == 0, sdl.GetErrorString())

    sdl.RenderCopy(renderer, texture, nil, nil)
    sdl.RenderPresent(renderer);
}