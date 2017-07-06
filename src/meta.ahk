;;;; AutoHotkey script of Aaron Harris
;;;; META-HOTKEYS
;;;;====================================================================

;; This file contains hotkey definitions that are used to control
;; AutoHotkey itself.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto meta_include
;;;;====================================================================

;; Show a window's class.
;;
;; This is usable even on machines where we can't run Window Spy for
;; lack of administrative privileges.
#h::
    WinGetClass, class, A
    MsgBox, The active window's class is "%class%"
    return

;; List all currently defined hotkeys.
#k::ListHotkeys

;; Suspend or unsuspend all hotkeys (except this one).
#s::Suspend

;;;;====================================================================
;;;; End meta.ahk
meta_include:
;;;;====================================================================
