;;;; AutoHotkey script of Aaron Harris
;;;; META-HOTKEYS
;;;;====================================================================

;; This file contains hotkey definitions that are used to control
;; AutoHotkey itself.

#Include keymap.ahk

global_keymap.bind("", "#h", Func("ahk_show_class"))
global_keymap.bind("", "#k", Func("ahk_list_hotkeys"))

;;;;====================================================================
;;;; End Auto-Execute Section
Goto meta_include
;;;;====================================================================

;; Show a window's class.
;;
;; This is usable even on machines where we can't run Window Spy for
;; lack of administrative privileges.
ahk_show_class() {
	WinGetClass, class, A
	MsgBox % "The active window's class is " . class
	return
}

ahk_list_hotkeys() {
	ListHotkeys
}

#s::Suspend

;;;;====================================================================
;;;; End meta.ahk
meta_include:
;;;;====================================================================
