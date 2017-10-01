;;;; AutoHotkey script of Aaron Harris
;;;; WINDOWS EXPLORER FEATURES
;;;;====================================================================

;;; This file defines hotkeys for use in Windows Explorer.

explorer := new App("Windows Explorer", "ahk_exe explorer.exe"
	, exit_keymap)

;; Use `M-u` for "up directory" (`M-<up>`).
explorer.keymap.remap("", "!u", "!{Up}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto explorer_include
;;;;====================================================================

;;;;====================================================================
;;;; End explorer.ahk
explorer_include:
;;;;====================================================================
