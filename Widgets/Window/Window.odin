package windows
import sdl "vendor:sdl2"
import "core:fmt"

WinTitle: cstring
XPos: i32
YPos: i32

@(private)
/* renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
RENDERER :: sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)

@(private)
window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN

@(private)
window := sdl.CreateWindow(
    WinTitle,
    sdl.WINDOWPOS_CENTERED,
    sdl.WINDOWPOS_CENTERED,
    XPos,
    YPos,
    window_flags,
)


@(export)
NewWindow :: proc(title: cstring = WinTitle, xAxis: i32 = XPos, yAxis: i32 = YPos)
{
    using window
    /* window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN */

    if (window == nil) {
        fmt.println("Failed to Open Window")
    }
    MakeWindow := window
    /* renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
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

    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)
    /* @export renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    assert(sdl_init == 0, sdl.GetErrorString())
}