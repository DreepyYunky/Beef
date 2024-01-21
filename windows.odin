// +build windows
package beef
import win "core:sys/windows"
import X "vendor:x11/xlib"
import "core:c"
import "core:unicode/utf16"

// Vectors
Vector2 :: struct {x, y: i32}
Vector3 :: struct {x, y, z: i32}
Vector4 :: struct {x, y, z, w: i32}
hwnd: win.HWND
// Functions
NewWindow :: proc(title: string, SizeX: i32, SizeY: i32)
{
	hInstance: win.HINSTANCE
	nCmdShow: win.c_int
	msg: win.MSG
	wc: win.WNDCLASSW = {}
	wc.style = win.CS_HREDRAW | win.CS_VREDRAW
	wc.hInstance = hInstance
	wc.lpfnWndProc = WndProc
	wc.lpszClassName = win.L("Beef")
	win.RegisterClassW(&wc)
	hwnd = win.CreateWindowW(
		wc.lpszClassName,
		win.utf8_to_wstring(title),
		win.WS_OVERLAPPEDWINDOW | win.WS_VISIBLE,
		win.CW_USEDEFAULT,
		win.CW_USEDEFAULT,
		SizeY,
		SizeX,
		nil,
		nil,
		hInstance,
		nil,
	)

	
	for win.GetMessageW(&msg, nil, 0, 0) {
		win.DispatchMessageW(&msg)
		win.TranslateMessage(&msg)
	}
	win.ShowWindow(hwnd, nCmdShow)
	win.UpdateWindow(hwnd)
}

@private WndProc :: proc "system" (hwnd: win.HWND, msg: win.UINT, wParam: win.WPARAM, lParam: win.LPARAM) -> win.LRESULT
{
	switch msg {
		case win.WM_PAINT:
			ps: win.PAINTSTRUCT
			hdc := win.BeginPaint(hwnd, &ps)
			win.EndPaint(hwnd, &ps)
		case win.WM_DESTROY:
			win.PostQuitMessage(0)
	}
	return win.DefWindowProcW(hwnd, msg, wParam, lParam);
}
