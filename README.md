# Beef, a simple GUI framework powered by SDL2

This is a WIP, planned free-to-use GUI library powered by Odin's SDL2 binding.

# Simple Hello World

```rust

package main
import beef "shared:Beef"

main :: proc() {
    beef.NewWindow("Tutorial", 300, 300)
    beef.NewText("Terminal.ttf", "Hello World", beef.Black)
}
```

# Widgets

## NewWindow(title: cstring, xAxis: i32, yAxis: i32)

Window Widget and the point where SDL2 is initialized.

## NewText(font: cstring, txt: cstring, color: sdl.Color)

New (static) Text using a loaded `.ttf` font. Using the TTF SDL2 extension.

## NewImage(image: cstring)

Image Renderer and decoder using SDL2's Image extension.

## SetBgColor(color: sdl.Color)

Set Background Color (default is white)