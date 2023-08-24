package window
import sdl "vendor:sdl2"
import "core:fmt"


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

    if (window == nil) {
        fmt.println("Failed to Open Window")
    }
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
    /* @(export=true)
    renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    sdl.RenderCopy(renderer, texture, nil, nil)
    sdl.RenderPresent(renderer);
}