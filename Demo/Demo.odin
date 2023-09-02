package demo
import bf "shared:Beef/Widgets"
import sdl "vendor:sdl2"
import "shared:Beef/Widgets/Colors"

main :: proc() {
    bf.NewWindow("The Beefy Demo", 450, 450)
    /* sdl.Init(sdl.INIT_VIDEO)
    SDLInit := sdl.Init(sdl.INIT_VIDEO) */
    bf.SetBgColor(Colors.Black)
    bf.NewText("Nerd Fond.ttf", "Hey dudes", Colors.Black)
}