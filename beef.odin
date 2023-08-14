package beef
import sdl "vendor:sdl2"
import "Widgets"

NewWindow :: proc(title: cstring, xAxis: i32, yAxis: i32) {
    window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN
    sdl.CreateWindow(
        title,
        sdl.WINDOWPOS_CENTERED,
        sdl.WINDOWPOS_CENTERED,
        xAxis,
        yAxis,
        window_flags,
    )
    flag := true
    for flag {
        sdl.Delay(1000)
    }
    
}
main :: proc() {
    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
    
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)

    assert(sdl_init == 0, sdl.GetErrorString())
}