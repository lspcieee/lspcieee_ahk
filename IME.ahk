;函数
setLayout(Layout,WinID){
DllCall("SendMessage", "UInt", WinID, "UInt", "80", "UInt", "1", "UInt", (DllCall("LoadKeyboardLayout", "Str", Layout, "UInt", "257")))
}
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}



Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )

OnMessage( MsgNum, "ShellMessage")
Return


ShellMessage( wParam,lParam ) {
  If ( wParam = 1 )
  {
		WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		;使用中文输入法
		If Winclass in TXGuiFoundation,       ;需要开启中文输入的窗口类名
		{
		  winget,WinID,id,ahk_class %WinClass%
		  ;中文
		  setLayout("00000804",WinID)
		}

		;使用英文输入法
		if (InStr(Winclass,"HwndWrapper") or InStr(Winclass,"dopus") or Winclass in Notepad++,OpusApp)
		{
			  winget,WinID,id,ahk_class %WinClass%

			  ;英文
			  setLayout("00000409",WinID)

		}


	}
}

;在vs2012中自动切换中英文输入法
#IfWinActive, ahk_class HwndWrapper
:*:// ::
	;//加空格 时 切换到中文输入法
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip("//")
	setLayout("00000804",WinID)
return
:Z*:///::
	;///注释时 切换到中文输入法（也可以输入///加空格）
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip("//")
	SendInput /
	setLayout("00000804",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:*:" ::
	;引号加空格 时 切换到中文输入法
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	SendInput "
	setLayout("00000804",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:*:`;`n::
	;分号加回车 时 切换的英文输入法
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip(";")
	SendInput `n
return

#IfWinActive, ahk_class HwndWrapper
:Z?*:`;`;::
	;两个分号时 切换的英文输入法
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:Z?*:  ::
	;输入两个空格 切换的中文输入法
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	setLayout("00000804",WinID)
return

#IfWinActive




