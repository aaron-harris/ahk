;;;; AutoHotkey script of Aaron Harris
;;;; AHK STUDIO
;;;;====================================================================

;;; This file contains hotkey definitions for use in AHK Studio.

ahk_studio := new App("AHK Studio", "AHK Studio"
	, editing_keymap
	, exit_keymap)

;; Use `C-[` and `C-]` to navigate between files.
;; Setting these hotkeys directly in AHK Studio doesn't seem to work.
ahk_studio.keymap.remap("", "^[", "!{Left}")
ahk_studio.keymap.remap("", "^]", "!{Right}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto ahk_studio_include
;;;;====================================================================

;;;;====================================================================
;;;; End ahk_studio.ahk
ahk_studio_include:
;;;;====================================================================
