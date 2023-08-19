package bgcolor
import sdl "vendor:sdl2"
import "../.."

SetBgColor :: proc(color: sdl.Color) {
    sdl.SetRenderDrawColor(renderer, color)
}