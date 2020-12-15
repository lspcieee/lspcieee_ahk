;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK版本：		1.1.23.01
; 语言：		中文
; 作者：		lspcieee <lspcieee@gmail.com>
; 网站：		http://www.lspcieee.com/
; 脚本功能：	个性化需求
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Win---># ; Shift--->+ ; Ctrl--->^ ; Alt--->!
; ::/d::此格式加回车执行
#SingleInstance force
;SendMode Input

;脚本重启
!^r::
Reload  ; Reload the script by Alt+Ctrl+R.
TrayTip,AHK, 脚本已重启
Return


;有道词典快捷键打开（有道词典已经设置为关闭窗口自动关闭程序，节省性能）
;!l::
;Run,C:\Users\lspcieee\AppData\Local\Youdao\Dict\Application\YodaoDict.exe
;Return


:*::d::  ; 当前日期
FormatTime, CurrentDateTime,, yyyy-MM-dd
sendbyclip(CurrentDateTime)
return

:*::t::  ; 当前日期
FormatTime, CurrentDateTime,, HH:mm
sendbyclip(CurrentDateTime)
return

:Z*?:`:`=::  ; 计算表达式

    ClipboardOld = %ClipboardAll%

	send +{Home}

    send ^c
	ClipWait
	Q:=Clipboard

	if fileexist("Temp.ahk")
	FileDelete Temp.ahk
	FileAppend send {End}`=`n,Temp.ahk
	FileAppend send `% %Q% ,Temp.ahk
	run Temp.ahk
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.

return

;mlo点击支持中文链接
#IfWinActive, ahk_class TfrmMyLifeMain
!o::
;MouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl
;MouseClick, left, OutputVarX, OutputVarY,5
	Send,^a
	Send,^c
	ClipWait
	StringReplace, Clipboard, Clipboard, file: ,, All
	StringReplace, Clipboard, Clipboard, `r`n ,, All
	;MsgBox,%clipboard%
	Run,%clipboard%

Return



#IfWinActive






=