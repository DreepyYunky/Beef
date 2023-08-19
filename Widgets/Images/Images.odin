// The Image Widget
package images
import sdl_img "vendor:sdl2/image"

NewImage :: proc(img: cstring) {
    sdl_img.Load(img)
    
}