// +build windows
package beef
import "core:fmt"
import "./Widgets"
import win "core:sys/windows"

@private BEEF_DEF_POS :: 1000

@private WinTitle: win.LPCWSTR
@private X: i32
@private Y: i32
when ODIN_OS == .Windows
{
    NewWindow :: proc(title: win.LPCWSTR = WinTitle, XSize: i32 = X, YSize: i32 = Y)
{

    WindowProc :: proc(hwnd: win.HWND, uMsg: win.UINT, wParam: win.WPARAM, LParam: win.LPARAM) -> win.LRESULT
    {
        switch uMsg{
            case win.WM_CLOSE:
                win.PostQuitMessage(0)
        }
        return 0
    }

    WinMain :: proc(hInstance: win.HINSTANCE, hPrevInstance: win.HINSTANCE, lpCmdLine: win.LPSTR, nCmdShow: i32) -> int
    {

        hWnd: win.HWND
        msg: win.MSG
        wc: win.WNDCLASSW
        wc.style = win.CS_HREDRAW | win.CS_VREDRAW
        wc.hInstance = hInstance
        wc.hCursor = win.LoadCursorA(nil, win.IDC_ARROW)
        wc.lpszClassName = distinct "Beef"
        
        hWnd = win.CreateWindowW(wc.lpszClassName, WinTitle, win.WS_OVERLAPPEDWINDOW | win.WS_VISIBLE, BEEF_DEF_POS, BEEF_DEF_POS, X, Y, nil, nil, hInstance, nil)

        win.ShowWindow(hWnd, nCmdShow);
        win.UpdateWindow(hWnd)

        for win.GetMessageW(&msg, nil, 0, 0) do win.DispatchMessageW(&msg)

        return msg.lParam
    }
}
}

when ODIN_OS != .Windows {
    #panic("NOT WINDOWS!!")
}