# Beef, a simple GUI framework powered by SDL2

This is a WIP, planned free-to-use GUI library powered by Odin's SDL2 binding.

# Simple Hello World

```
package main
import beef "shared:Beef"

main :: proc() {
    beef.NewWindow("Tutorial", 300, 300)
    beef.NewText("Terminal.ttf", "Hello World", beef.Black)
}
```

# Welcome to the Remove SDL2 Dependency Branch

## Why?

### SDL2.dll

The first issue I've felt is that SDL requires SDL2.dll which is the compiled version of the package

### Just a Good challenge
I like challenges

**Please Contribute**

**Probably gonna remove this bit afterwards when this branch merges**
