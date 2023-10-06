// +build windows
package beef
import "core:fmt"
import "./Widgets"
import win "core:sys/windows"

when ODIN_OS == .Windows
{
    NewWindow :: proc(title: string, XSize: i32, YSize: i32)
{
    hWnd: win.HWND

    WindowProc :: proc(hwnd: win.HWND, uMsg: win.UINT, wParam: win.WPARAM, LParam: win.LPARAM) -> win.LRESULT
    {
        switch uMsg{
            case win.WM_CLOSE:
                win.PostQuitMessage(0)
        }
        return 0
    }

    WinMain :: proc(hInstance: win.HINSTANCE, hPrevInstance: win.HINSTANCE, lpCmdLine: win.LPSTR, nCmdShow: int) -> int
    {
        wc: win.WNDCLASSEXA
        wc.cbSize = size_of(win.WNDCLASSEXA)
        wc.style = win.CS_HREDRAW | win.CS_VREDRAW
        wc.hInstance = hInstance
        wc.hCursor = win.LoadCursorA(nil, win.IDC_ARROW)
        wc.lpszClassName = "Beef"

        hWnd = win.CreateWindowW(wc.lpszClassName)
        

    }
}
}

when ODIN_OS != .Windows {
    #panic("")
}