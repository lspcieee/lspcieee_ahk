;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK版本：		1.1.23.01
; 语言：		中文
; 作者：		lspcieee <lspcieee@gmail.com>
; 网站：		http://www.lspcieee.com/
; 脚本功能：	启动主文件
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
SetTitleMatchMode RegEx

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#Include IME.ahk
#Include lspcieee.ahk
