;;;; AutoHotkey script of Aaron Harris
;;;; WINDOWS EXPLORER FEATURES
;;;;====================================================================

;;; This file defines hotkeys for use in Windows Explorer.

explorer_context := "ahk_exe explorer.exe"
explorer_keymap := new Keymap("ahk_exe explorer.exe")
register_context(explorer_context, [exit_keymap])

;; Use `M-u` for "up directory" (`M-<up>`).
explorer_keymap.remap("", "!u", "!{Up}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto explorer_include
;;;;====================================================================

;;;;====================================================================
;;;; End explorer.ahk
explorer_include:
;;;;====================================================================
