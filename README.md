# Beef, a simple GUI framework powered by SDL2

This is a WIP, planned free-to-use GUI library powered by Odin's SDL2 binding.

# Simple Hello World

```react

package main
import beef "shared:Beef"

main :: proc() {
    beef.NewWindow("Tutorial", 300, 300)
    beef.NewText("Terminal.ttf", "Hello World", beef.Black)
}
```