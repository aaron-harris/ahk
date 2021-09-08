;;;; AutoHotkey script of Aaron Harris
;;;; CHROME FEATURES
;;;;====================================================================

;;; This file contains hotkeys and hotstrings for use in Google Chrome.

chrome := new App("Chrome", "ahk_exe chrome.exe"
	, editing_keymap
	, exit_keymap
	, tabs_keymap)

;; Use `C-[` and `C-]` to navigate between tabs.
chrome.keymap.remap("", "^[", "{Blind}^+{Tab}")
chrome.keymap.remap("", "^]", "{Blind}^{Tab}")

;; Use `M-[` and `M-]` to rearrange tabs.
chrome.keymap.remap("", "![", "^+{PgUp}")
chrome.keymap.remap("", "!]", "^+{PgDn}")

;; Use `M-x` to select the address bar.
chrome.keymap.remap("", "!x", "{F6}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto chrome_include
;;;;====================================================================

;;;;====================================================================
;;;; End chrome.ahk
chrome_include:
;;;;====================================================================
