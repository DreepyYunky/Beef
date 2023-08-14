package text
import sdl "vendor:sdl2"
import sdl_ttf "vendor:sdl2/ttf"
import "core:fmt"
import "../Colors"

TxtID :: enum {
    title,
}

Txt :: struct {
    texture: ^sdl.Texture,
    dest: sdl.Rect,
}

NewText :: proc(font: cstring, txt: cstring, color: sdl.Color) {
    sdl_ttf.Init()
    Font := sdl_ttf.OpenFont(font, 80)
    sdl_ttf.RenderUTF8_Blended(Font, txt, color)
}