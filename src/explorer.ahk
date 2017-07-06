;;;; AutoHotkey script of Aaron Harris
;;;; WINDOWS EXPLORER FEATURES
;;;;====================================================================

;; This file defines hotkeys for use in Windows Explorer.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto explorer_include
;;;;====================================================================

#IfWinActive ahk_exe explorer.exe
	
;; Use `C-M-u` for "up directory" (`M-<up>`).
^!u::
Send !{Up}
return

#IfWinActive
	
;;;;====================================================================
;;;; End explorer.ahk
explorer_include:
;;;;====================================================================
