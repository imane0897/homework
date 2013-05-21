.386
.model flat,stdcall
option casemap:none

include colorPicker.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov    hInstance,eax
	invoke GetCommandLine
	invoke InitCommonControls
	mov		CommandLine,eax
	invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT
	invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
	LOCAL	wc:WNDCLASSEX
	LOCAL	msg:MSG

	mov		wc.cbSize,sizeof WNDCLASSEX
	mov		wc.style,CS_HREDRAW or CS_VREDRAW
	mov		wc.lpfnWndProc,offset WndProc
	mov		wc.cbClsExtra,NULL
	mov		wc.cbWndExtra,DLGWINDOWEXTRA
	push	hInst
	pop		wc.hInstance
	mov		wc.hbrBackground,COLOR_BTNFACE+1
	mov		wc.lpszMenuName,IDM_MENU
	mov		wc.lpszClassName,offset ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov		wc.hIcon,eax
	mov		wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov		wc.hCursor,eax
	invoke RegisterClassEx,addr wc
	invoke CreateDialogParam,hInstance,IDD_DIALOG,NULL,addr WndProc,NULL
	invoke ShowWindow,hWnd,SW_SHOWNORMAL
	invoke UpdateWindow,hWnd
	.while TRUE
		invoke GetMessage,addr msg,NULL,0,0
	  .BREAK .if !eax
		invoke TranslateMessage,addr msg
		invoke DispatchMessage,addr msg
	.endw
	mov		eax,msg.wParam
	ret

WinMain endp

WndProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	; �����������
	LOCAL @stPoint:POINT

	LOCAL @hDcShowPic:HDC
	LOCAL @hDcScreen:HDC
	LOCAL @hDcShowColor:HDC
	
	LOCAL @dwDx:dword
	LOCAL @dwDy:dword
	
	LOCAL @colorRect:RECT
	LOCAL @hColorWin:HWND
	LOCAL @dwColor:DWORD
	LOCAL @hBrush:HBRUSH
	LOCAL @hBrushOld:HBRUSH
	
	LOCAL @colorRed:byte
	LOCAL @colorGreen:byte
	LOCAL @colorBlue:byte

	mov		eax,uMsg
	.if eax==WM_INITDIALOG
		; ����Ի���Ĵ��ھ��
		push	hWin
		pop		hWnd
		
		; ���������ڵ�ͼ��
		invoke LoadIcon, hInstance, IDI_WIN_MAIN
		invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, eax
		
		; ���ö�ʱ��
		invoke SetTimer, hWnd, NULL, 100, NULL
		
	.elseif eax == WM_TIMER		; ��Ӧ��ʱ������Ϣ
		; ��ȡ��ǰ��������ֵ
		invoke GetCursorPos, addr @stPoint
		
		; ��XY������ʾ���Ի�����
		invoke SetDlgItemInt, hWnd, IDC_EDT_POSX, @stPoint.x, FALSE
		invoke SetDlgItemInt, hWnd, IDC_EDT_POSY, @stPoint.y, FALSE
	
		; ��XY���꿿ǰһ��
		mov eax, @stPoint.x
		sub eax, 8
		mov @dwDx, eax
		mov eax, @stPoint.y
		sub eax, 9
		mov @dwDy, eax
		
		; ��ȡ������Ļ��DC
		invoke GetDC, NULL
		mov @hDcScreen, eax
		
		; ��ȡ��ʾ��Ļ��������Ĵ���DC
		invoke GetDlgItem, hWnd, IDC_IMG_SHOWPIC
		invoke GetDC, eax
		mov @hDcShowPic, eax
		
		; ����Ļ�ƶ�������Ƶ��ƶ��Ĵ���DC��
		invoke StretchBlt, @hDcShowPic, 0, 0, 112, 94, @hDcScreen, @dwDx, @dwDy, 16, 18, SRCCOPY
	
		; ��ͼƬ�����һ��ʮ�����Ա�����������ĵ�
		invoke CreatePen, PS_SOLID, 1, 0
		mov @hBrush, eax
		; ��ͼƬ���ϻ�һ������
		invoke MoveToEx, @hDcShowPic, 0, 47, NULL
		invoke LineTo, @hDcShowPic, 112, 47
		; ��ͼƬ���ϻ�һ������
		invoke MoveToEx, @hDcShowPic, 56, 0, NULL
		invoke LineTo, @hDcShowPic, 56, 94
		
		; ��ʾ��ǰ���ָ�����ɫ
		invoke GetDlgItem, hWnd, IDC_IMG_COLOR
		mov @hColorWin, eax
		invoke GetDC, eax
		mov @hDcShowColor, eax
		
		; ������ʾ��ɫ��ͼƬ�������
		mov @colorRect.left, 0
		mov @colorRect.top, 0
		mov @colorRect.right, 112
		mov @colorRect.bottom, 15
		
		; ��ȡ��Ļ�����ָ������ɫֵ
		invoke GetPixel, @hDcScreen, @stPoint.x, @stPoint.y
		mov @dwColor, eax
		
		; Ϊ��ǰ��ȡ����ɫֵ����һ��ʵ�Ļ�ˢ
		invoke CreateSolidBrush, @dwColor
		mov @hBrush, eax
		
		; ����ʾ��ɫ��ͼƬ������仭ˢ�ƶ�����ɫֵ
		invoke FillRect, @hDcShowColor, addr @colorRect, @hBrush
	
		; ���32λ����ɫֵ�������ֽ����͵ı����У�Ȼ����ʾ
		mov eax, @dwColor
		mov @colorRed, al
		mov @colorGreen, ah
		ror eax, 16
		mov @colorBlue, al
		
		invoke SetDlgItemInt, hWnd, IDC_EDT_RED, @colorRed, FALSE
		invoke SetDlgItemInt, hWnd, IDC_EDT_GREEN, @colorGreen, FALSE
		invoke SetDlgItemInt, hWnd, IDC_EDT_BLUE, @colorBlue, FALSE
	
	.elseif eax==WM_COMMAND
		mov		eax,wParam
		and		eax,0FFFFh
		.if eax==IDM_FILE_EXIT
			invoke SendMessage,hWin,WM_CLOSE,0,0
		.elseif eax==IDM_HELP_ABOUT
			invoke ShellAbout,hWin,addr AppName,addr AboutMsg,NULL
		.endif
;	.elseif eax==WM_SIZE
	.elseif eax==WM_CLOSE
		invoke DestroyWindow,hWin
	.elseif uMsg==WM_DESTROY
		invoke PostQuitMessage,NULL
	.else
		invoke DefWindowProc,hWin,uMsg,wParam,lParam
		ret
	.endif
	xor    eax,eax
	ret

WndProc endp

end start