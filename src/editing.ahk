;;;; AutoHotkey script of Aaron Harris
;;;; EDITING HOTKEYS
;;;;====================================================================

;;; This file defines a family keymap for Emacs-style editing keys.
;;;
;;; This keymap is a child of the navigation keymap, so individual apps
;;; need only register with this keymap, not both.

editing_keymap := new Keymap(null, "family")
navigation_keymap.addChild(editing_keymap)

;; Editing
editing_keymap.remap("", "^o", "{Enter}{Left}")

;; Kill/delete
editing_keymap.remap("", "^d", "{Delete}")
editing_keymap.remap("", "!d", "^+{Right}^x")
editing_keymap.bind("", "^w", Func("finalize_mark").bind("^x"))
editing_keymap.bind("", "!w", Func("copy_region"))
editing_keymap.bind("", "^k", Func("finalize_mark").bind("+{End}^x"))

;; Yank
editing_keymap.bind("", "^y", Func("finalize_mark").bind("^v"))

;; Undo/redo
editing_keymap.remap("", "^/", "^z")
editing_keymap.remap("", "^!/", "^y")

;; Minor apps in this family:
editing_keymap.addContext("ahk_class Notepad")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto editing_include
;;;;====================================================================

;; Copy the region and then de-select it, as in Emacs.
copy_region() {
	insert(this, "^c")
	clear_selection()
}

;; Insert the given keys and deactivate the mark.
finalize_mark(keys) {
	insert(this, keys)
	set_mark(false)
}

;;;;====================================================================
;;;; End meta.ahk
editing_include:
;;;;====================================================================
