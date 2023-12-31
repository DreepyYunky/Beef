/*
    BEEF: A simple, powerful SDL2-powered library, Made in Odin
    LICENSE:

    MIT License

Copyright (c) 2023 Yunky86

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/


package beef
import sdl "vendor:sdl2"
import "core:fmt"
import "shared:Beef/Colors"
import "vendor:sdl2/ttf"
import img "vendor:sdl2/image"


// Let's start by defining all the variables, structs and enums we'll need
@(private)
TextID :: enum {
    text
}

@(private)
Text :: struct {
    tex: ^sdl.Texture,
    dest: sdl.Rect,
}

event : sdl.Event

IMG_FLAGS :: img.INIT_JPG | img.INIT_PNG | img.INIT_TIF | img.INIT_WEBP

@(private)
txtColor: sdl.Color

@(private)
text: cstring

@(private)
surface : ^sdl.Surface

@(private)
texture : ^sdl.Texture

@(private)
Fnt: cstring

@(private)
Font := ttf.OpenFont(Fnt, 80)

@(private)
texts: [TextID]Text

@(private)
dest_rect := sdl.Rect{}

// I'm now going to define variables that determine whether a function has been called or not
@(private)
NewText_called: bool = false

@(export)
NewText :: proc(font: cstring = Fnt, txt: cstring = text, color: sdl.Color = txtColor) {
    ttf_init := ttf.Init()
    // Model the size of text.
    NewText_called = true
    if ttf_init < 0 do fmt.println("ERROR: FAILED TO INITIALIZE SDL_TTF")

    assert(ttf_init != -1, sdl.GetErrorString())

    ttf.RenderUTF8_Blended(Font, txt, color)
    /* render: ^sdl.Renderer */
    

    
    // Render text
    //sdl.RenderDrawLine(renderer)
    
}
WinTitle: cstring
XSize: i32
YSize: i32


@(private)
renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)

@(private)
window: ^sdl.Window

@(private)
window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN

@(export)
NewWindow :: proc(title: cstring, xAxis: i32, yAxis: i32)
{
    WinTitle = title
    XSize = xAxis
    YSize = yAxis
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)

    if sdl_init < 0 do fmt.println("ERROR: FAILED TO INITIALIZED SDL2")


    assert(sdl_init != -1, sdl.GetErrorString())

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
    event: sdl.Event
    assert(window != nil, sdl.GetErrorString())
    quit: bool = false

    // The loop that keeps the App up.
    loop : for {
        if sdl.PollEvent(&event) {
            if event.type == sdl.EventType.QUIT do break loop // This line allows for closing the window using the "X" on the window
            if event.type == sdl.EventType.KEYDOWN
            {
                #partial switch event.key.keysym.scancode
                {
                    case .ESCAPE:
                        break loop
                }
            }
        }
        if NewText_called == true {
            // Render text
            texts[TextID.text] = RenderText(text, 3)
            text_render : Text = texts[TextID.text]
            dest_rect.x = (XSize / 2) - (text_render.dest.h / 2)
            dest_rect.y = (YSize / 2) + (text_render.dest.w)
        }
        sdl.RenderCopy(renderer, texture, nil, nil)
        //sdl.RenderPresent(renderer)
        sdl.RenderClear(renderer)

    }
}

@(export)
SetBgColor :: proc(color: sdl.Color) {
    // Now I'm going to do a really complicated system in which I change the command based the color attr.
    switch color {
        case Colors.Black:
            sdl.RenderClear(renderer);
            sdl.SetRenderDrawColor(renderer, 0, 0, 0, 1)
            rect : sdl.Rect = {100, 100, 200, 200}

            sdl.RenderFillRect(renderer, &rect)
            sdl.RenderPresent(renderer)

        case Colors.Blue:
            sdl.SetRenderDrawColor(renderer, 34, 69, 164, 1)
        
        case Colors.Red:
            sdl.SetRenderDrawColor(renderer, 255, 0, 0, 1)
        
    }
}

@(export)
NewImage :: proc(image: cstring) {

    image_init := img.Init(IMG_FLAGS)

    if ((image_init & IMG_FLAGS) != IMG_FLAGS) do fmt.println("ERROR: FAILED TO INITIALIZE SDL_IMAGE")
    // Load the image
    load := img.Load(image)
    if load == nil do fmt.println("ERROR: FAILED TO LOAD %s!", image)
    screen: ^sdl.Surface
    
}

@(private)
CleanWin :: proc() {
    ttf.Quit()
    sdl.Quit()
    sdl.DestroyWindow(window)
}

RenderText :: proc(str: cstring, scale: i32 =1) -> Text
{
    
    surface = ttf.RenderText_Solid(Font, text, txtColor)
    defer sdl.FreeSurface(surface)
    ttf.SizeText(Font, str, &dest_rect.w, &dest_rect.h)

    scancode := event.key.keysym.scancode
    font_size : i32 = 20
    dest_rect.w *= scale
    dest_rect.h *= scale

    return Text {tex = texture, dest = dest_rect}
}