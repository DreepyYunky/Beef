package text
import sdl "vendor:sdl2"
import sdl_ttf "vendor:sdl2/ttf"
import "core:fmt"
import "shared:Beef"

TxtID :: enum {
    title,
}

Txt :: struct {
    texture: ^sdl.Texture,
    dest: sdl.Rect,
}

NewText :: proc(font: cstring, txt: cstring, color: sdl.Color) {
    ttf := sdl_ttf.Init()
    assert(ttf != -1, sdl.GetErrorString())
    Font := sdl_ttf.OpenFont(font, 80)
    sdl_ttf.RenderUTF8_Blended(Font, txt, color)
    surface := sdl_ttf.RenderText_Solid(Font, txt, color)
    render: ^sdl.Renderer
    texture := sdl.CreateTextureFromSurface(renderer, surface)
    sdl.FreeSurface(surface)
}