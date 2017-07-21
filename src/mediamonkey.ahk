;;;; AutoHotkey script of Aaron Harris
;;;; MEDIAMONKEY FEATURES
;;;;====================================================================

;; This file contains hotkeys and hotstrings for use in MediaMonkey.

;; Use `S-<return>` for pipe in track property window.
;; This helps with keyboards that have a tall enter key.
mediamonkey_props_keymap := new Keymap("ahk_class TFSongProperties")
mediamonkey_props_keymap.remap("", "+{Enter}", "|")

mediamonkey_keymap := new Keymap("ahk_exe MediaMonkey.exe")

tabs_keymap.addContext("ahk_exe MediaMonkey.exe")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto mediamonkey_include
;;;;====================================================================
	
;;;;====================================================================
;;;; End access.ahk
mediamonkey_include:
;;;;====================================================================
