// +build linux
package beef

when ODIN_OS == .Linux
{
    import unix "core:sys/unix"

    NewWindow :: proc(title: string, )
}