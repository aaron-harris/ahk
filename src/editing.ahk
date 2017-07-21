;;;; AutoHotkey script of Aaron Harris
;;;; EDITING HOTKEYS
;;;;====================================================================

;;; This file defines a family keymap for Emacs-style editing keys.

editing_keymap := new Keymap(null, "family")

;; `C-x` prefix key
editing_keymap.bind("", "^x", Func("prefix_key"))

;; Navigation
editing_keymap.remap("", "^f", "{Right}")
editing_keymap.remap("", "^b", "{Left}")
editing_keymap.remap("", "^n", "{Down}")
editing_keymap.remap("", "^p", "{Up}")
editing_keymap.remap("", "^a", "{Home}")
editing_keymap.remap("", "^e", "{End}")
editing_keymap.remap("", "!f", "^{Right}")
editing_keymap.remap("", "!b", "^{Left}")

;; Selection
editing_keymap.remap("^x", "h", "^a")

;; Kill/delete
editing_keymap.remap("", "^d", "{Delete}")
editing_keymap.remap("", "!d", "^+{Right}^x")
editing_keymap.remap("", "^w", "^x")
editing_keymap.remap("", "!w", "^c")
editing_keymap.remap("", "^k", "+{End}^x")

;; Yank
editing_keymap.remap("", "^y", "^v")


;; Minor apps in this family:
editing_keymap.addContext("ahk_class Notepad")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto editing_include
;;;;====================================================================

;;;;====================================================================
;;;; End meta.ahk
editing_include:
;;;;====================================================================
