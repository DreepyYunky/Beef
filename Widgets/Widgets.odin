package widgets
import sdl "vendor:sdl2"
import sdl_ttf "vendor:sdl2/ttf"
import "core:fmt"
import img "vendor:sdl2/image"
import "Colors"

@(private)
txtColor: sdl.Color

@(private)
text: cstring

@(private)
surface := sdl_ttf.RenderText_Solid(Font, text, txtColor)

@(private)
texture := sdl.CreateTextureFromSurface(renderer, surface)

@(private)
Fnt: cstring
@(private)
Font := sdl_ttf.OpenFont(Fnt, 80)

@(export)
NewText :: proc(font: cstring = Fnt, txt: cstring = text, color: sdl.Color = txtColor) {
    ttf := sdl_ttf.Init()
    assert(ttf != -1, sdl.GetErrorString())
    sdl_ttf.RenderUTF8_Blended(Font, txt, color)
    render: ^sdl.Renderer
    sdl.FreeSurface(surface)
}

WinTitle: cstring
XPos: i32
YPos: i32


@(private)
renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)

@(private)
/* window := sdl.CreateWindow(
    WinTitle,
    sdl.WINDOWPOS_CENTERED,
    sdl.WINDOWPOS_CENTERED,
    XPos,
    YPos,
    window_flags,
) */
window: ^sdl.Window

@(private)
window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN

@(export)
NewWindow :: proc(title: cstring, xAxis: i32, yAxis: i32)
{
    WinTitle = title
    XPos = xAxis
    YPos = yAxis
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
    assert(sdl_init != -1, sdl.GetErrorString())
    /* using window */
    /* window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN */

    window = sdl.CreateWindow(
        title,
        sdl.WINDOWPOS_CENTERED,
        sdl.WINDOWPOS_CENTERED,
        xAxis,
        yAxis,
        window_flags,
    )

    assert(window != nil, sdl.GetErrorString())
    defer CleanWin()

    if (window == nil) {
        fmt.println("Failed to Open Window")
    }
    /* renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    event: sdl.Event
    assert(window != nil, sdl.GetErrorString())
    quit: bool = false
    loop : for {
        if sdl.PollEvent(&event) {
            if EndWin(&event) do break loop
            HandleEvents(&event)
        }
        sdl.RenderCopy(renderer, texture, nil, nil)
        sdl.RenderPresent(renderer)

        sdl.Delay(1000) // Delay for 1 second
    }

    /* for quit {
        sdl.Delay(1000)
    } */
    /* @(export=true)
    renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
}

@(export)
SetBgColor :: proc(color: sdl.Color) {
    // Now I'm going to do a really complicated system in which I change the command based the color attr.
    /* sdl.SetRenderDrawColor(renderer, color[0]) */
    switch color {
        case Colors.Black:
            sdl.SetRenderDrawColor(renderer, 0, 0, 0, 1)
        
        case Colors.Blue:
            sdl.SetRenderDrawColor(renderer, 34, 69, 164, 1)
        
        case Colors.Red:
            sdl.SetRenderDrawColor(renderer, 255, 0, 0, 1)
        
        
    }
}

@(export)
NewImage :: proc(image: cstring) {
    img.Load(image)
    
}

// Handle Events isn't something accessible to the developer
@(private)
HandleEvents :: proc(event: ^sdl.Event) {
    event : sdl.Event
    if event.type == sdl.EventType.WINDOWEVENT
    {
        if event.window.windowID == sdl.GetWindowID(window)
        {
            if event.window.event == sdl.WindowEventID.RESIZED
            {
                XPos = event.window.data1
                YPos = event.window.data2
            }
        }
    }
}

@(private)
EndWin :: proc(event: ^sdl.Event) -> (exit: bool) {
    exit = false
    
    if event.type == sdl.EventType.QUIT || event.key.keysym.scancode == .ESCAPE
    {
        exit = true
    }

    return
}

@(private)
CleanWin :: proc() {
    sdl_ttf.Quit()
    sdl.Quit()
    sdl.DestroyWindow(window)
}