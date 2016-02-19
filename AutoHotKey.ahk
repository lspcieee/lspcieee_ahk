#Persistent
SetTitleMatchMode RegEx

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#Include IME.ahk
#Include lspcieee.ahk
