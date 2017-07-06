;;;; AutoHotkey script of Aaron Harris
;;;; MEDIAMONKEY FEATURES
;;;;====================================================================

;; This file contains hotkeys and hotstrings for use in MediaMonkey.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto mediamonkey_include
;;;;====================================================================

#IfWinActive ahk_exe MediaMonkey.exe

;; Use `C-[` and `C-]` to navigate between tabs.
^[::Send {Blind}^+{Tab}
^]::Send {Blind}^{Tab}
    
#IfWinActive ahk_class TFSongProperties

;; Use `S-<return>` for pipe in track property window.
;; This helps with keyboards that have a tall enter key.
+Enter::Send |

#IfWinActive

;;;;====================================================================
;;;; End access.ahk
mediamonkey_include:
;;;;====================================================================
