;;;; AutoHotkey script of Aaron Harris
;;;; AHK STUDIO
;;;;====================================================================

;;; This file contains hotkey definitions for use in AHK Studio.

ahk_studio_context := "^AHK Studio"
ahk_studio_keymap := new Keymap("^AHK Studio")
register_context(ahk_studio_context, [
	, editing_keymap,
	, exit_keymap])

;; Use `C-[` and `C-]` to navigate between files.
;; Setting these hotkeys directly in AHK Studio doesn't seem to work.
ahk_studio_keymap.remap("", "^[", "!{Left}")
ahk_studio_keymap.remap("", "^]", "!{Right}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto ahk_studio_include
;;;;====================================================================

;; Because AHK Studio is defined in AHK, its native hotkeys interfere
;; with ours.  These declarations up the input level so that we can
;; override the native hotkeys (I'm not entirely sure why this works),
;; but they never get called as hotkeys because the keymap hotkeys get
;; defined first and take precedence.
#InputLevel 1

^a::
^e::
^y::
^[::
^]::
	return

#InputLevel 0

;;;;====================================================================
;;;; End ahk_studio.ahk
ahk_studio_include:
;;;;====================================================================
