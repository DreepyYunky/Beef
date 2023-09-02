# Widgets

## NewWindow(title: cstring, xAxis: i32, yAxis: i32)

Window Widget and the point where SDL2 is initialized.\

## NewText(font: cstring, txt: cstring, color: sdl.Color)

New (static) Text using a loaded `.ttf` font. Using the TTF SDL2 extension.

## NewImage(image: cstring)

Image Renderer and decoder using SDL2's Image extension.

## SetBgColor(color: sdl.Color)

Set Background Color (default is white)