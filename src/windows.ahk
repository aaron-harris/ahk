;;;; AutoHotkey script of Aaron Harris
;;;; WINDOWS HOTKEYS
;;;;====================================================================

;; This file modifies hotkeys that exist by default in Windows,
;; particularly those that use the Windows key.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto windows_include
;;;;====================================================================

;; Function to remove a pre-existing hotkey and send a key sequence to
;; Emacs, if it is the currently active window.  With use of the prefix
;; sequences for modifier keys, this can allow Emacs to reuse the key.
remove_hotkey(emacs_keys := "") {
	if WinActive("ahk_class Emacs") {
		SendInput %emacs_keys%
	}
	;; Do nothing if Emacs is not active.
}

;; Disable Win+<Enter> hotkey (the screen-reader).
#Enter::remove_hotkey("^x@s{Enter}")

;;;;====================================================================
;;;; End windows.ahk
windows_include:
;;;;====================================================================
