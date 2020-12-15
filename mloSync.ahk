;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK版本：		1.1.23.01
; 语言：		中文
; 作者：		lspcieee <lspcieee@gmail.com>
; 网站：		http://www.lspcieee.com/
; 脚本功能：	mlo 定时切换到界面，自动同步，然后自动最小化
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent

SetTimer, syncMlo, 15000
return

syncMlo:
TrayTip,AHK, 同步时间到了
ifWinExist ahk_class TfrmMyLifeMain
{
	winactivate
	send {F9}
	sleep, 200
	WinMinimize ahk_class TfrmMyLifeMain
}
else
{
	run D:\soft\MLO4_cn\mlo.exe
	WinWait ahk_class TfrmMyLifeMain
	send {F9}
	sleep, 200
	WinMinimize ahk_class TfrmMyLifeMain
}
return


;脚本重启
!^r::
Reload  ; Reload the script by Alt+Ctrl+R.
TrayTip,AHK, 脚本已重启
Return
