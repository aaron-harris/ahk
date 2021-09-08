;;;; AutoHotkey script of Aaron Harris
;;;; MEDIAMONKEY FEATURES
;;;;====================================================================

;; This file contains hotkeys and hotstrings for use in MediaMonkey.

mediamonkey_props := new App("MediaMonkey properties", "ahk_class TFSongProperties"
	, editing_keymap)
mediamonkey := new App("MediaMonkey", "ahk_exe MediaMonkey.exe"
	, exit_keymap
	, navigation_keymap
	, tabs_keymap)

;;;;====================================================================
;;;; End Auto-Execute Section
Goto mediamonkey_include
;;;;====================================================================
	
;;;;====================================================================
;;;; End mediamonkey.ahk
mediamonkey_include:
;;;;====================================================================
