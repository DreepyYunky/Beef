package demo
import bf "shared:Beef"
import sdl "vendor:sdl2"
import "shared:Beef/Colors"

main :: proc() {
    bf.NewWindow("The Beefy Demo", 450, 450)
    /* sdl.Init(sdl.INIT_VIDEO)
    SDLInit := sdl.Init(sdl.INIT_VIDEO) */
    bf.SetBgColor(Colors.Red)
    bf.NewText("Nerd Font.ttf", "Hey dudes", Colors.Black)
}