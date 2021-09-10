;;;; AutoHotkey script of Aaron Harris
;;;; MEDIAMONKEY FEATURES
;;;;====================================================================

;; This file contains hotkeys and hotstrings for use in MediaMonkey.

mediamonkey := new App("MediaMonkey", "ahk_exe MediaMonkey.exe"
	, exit_keymap
	, navigation_keymap
	, tabs_keymap)

;; Enable editing keys only in the "Properties" dialog
mediamonkey_props := new App("MediaMonkey properties", "ahk_exe MediaMonkey.exe ahk_class chromium"
	, editing_keymap)

;;;;====================================================================
;;;; End Auto-Execute Section
Goto mediamonkey_include
;;;;====================================================================
	
;;;;====================================================================
;;;; End mediamonkey.ahk
mediamonkey_include:
;;;;====================================================================
