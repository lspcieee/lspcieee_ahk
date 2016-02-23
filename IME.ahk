;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK版本：		1.1.23.01
; 语言：		中文
; 作者：		lspcieee <lspcieee@gmail.com>
；网站：		http://www.lspcieee.com/
; 脚本功能：	自动切换输入法
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;=====分组配置
;中文输入法的分组
GroupAdd,cn,ahk_exe QQ.exe  ;QQ
GroupAdd,cn,ahk_exe WINWORD.EXE ;word
GroupAdd,cn,ahk_exe MindManager.exe

;英文输入法的分组
GroupAdd,en,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,en,ahk_exe dopus.exe 
GroupAdd,en,ahk_class Notepad++

;编辑器分组
GroupAdd,editor,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,editor,ahk_exe notepad.exe ;记事本
GroupAdd,editor,ahk_class Notepad++




;函数
;从剪贴板输入到界面
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}


setChineseLayout(){
	;发送中文输入法切换快捷键，请根据实际情况设置。
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Up}
}
setEnglishLayout(){
	;发送英文输入法切换快捷键，请根据实际情况设置。
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},

	send {Ctrl Down}{Space}
	send {Ctrl Up}
}

;监控消息回调ShellMessage，并自动设置输入法
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {
	If ( wParam = 1 )
	{
		WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		Sleep, 1000
		WinActivate,ahk_class %Winclass%
		;WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		IfWinActive,ahk_group cn
		{
			setChineseLayout()
			TrayTip,AHK, 已自动切换到中文输入法
			return
		}
		IfWinActive,ahk_group en
		{
			setEnglishLayout()
			TrayTip,AHK, 已自动切换到英文输入法
			return
		}
	}
}

;在所有编辑器中自动切换中英文输入法
#IfWinActive,ahk_group editor
:*:// ::
	;//加空格 时 切换到中文输入法
	setEnglishLayout()
	sendbyclip("//")
	setChineseLayout()
return
:Z*:///::
	;///注释时 切换到中文输入法（也可以输入///加空格）
	setEnglishLayout()
	sendbyclip("//")
	SendInput /
	setChineseLayout()
return
:*:" ::
	;引号加空格 时 切换到中文输入法
	setEnglishLayout()
	SendInput "
	setChineseLayout()
return
:*:`;`n::
	;分号加回车 时 切换的英文输入法
	setEnglishLayout()
	sendbyclip(";")
	SendInput `n
return
:Z?*:`;`;::
	;两个分号时 切换的英文输入法
	setEnglishLayout()
return
:Z?*:  ::
	;输入两个空格 切换的中文输入法
	setEnglishLayout()
	setChineseLayout()
return

#IfWinActive






