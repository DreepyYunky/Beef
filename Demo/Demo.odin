package demo
import bf "shared:Beef"
import bf_txt "shared:Beef/Widgets/Text"

main :: proc() {
    bf.NewWindow("Demo Odin", 200, 200)
    bf_txt.NewText()
}