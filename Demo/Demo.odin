package demo
import bf "shared:Beef"
import bf_txt "shared:Beef/Widgets/Text"
import bf_col "shared:Beef/Widgets/Colors"

main :: proc() {
    bf.NewWindow("Demo Odin", 200, 200)
    bf_txt.NewText("Nerd Font.ttf", "Hi", bf_col.Black)
}