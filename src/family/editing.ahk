﻿;;;; AutoHotkey script of Aaron Harris
;;;; EDITING HOTKEYS
;;;;====================================================================

;;; This file defines a family keymap for Emacs-style editing keys.
;;;
;;; This keymap is a child of the navigation keymap, so individual apps
;;; need only register with this keymap, not both.

editing_keymap := new Keymap("Editing family", null, "family")
navigation_keymap.addChild(editing_keymap)

;; Editing
editing_keymap.remap("", "^o", "{Enter}{Left}")

;; Kill/delete
editing_keymap.bind("", "^w", Func("finalize_mark").bind("^x"))
editing_keymap.bind("", "!w", Func("copy_region"))
editing_keymap.bind("", "^k", Func("finalize_mark").bind("+{End}^x"))
editing_keymap.remap("", "^d", "{Delete}")
    ;; Note that the semantics of `M-d` and `M-DEL` are different from
	;; Emacs, because of the difficulty of clearing the selection.
	;; In the presence of an active selection, these commands just
	;; modify that selection (possibly shrinking it) and then cut.
editing_keymap.bind("", "!d", Func("finalize_mark").bind("^+{Right}^x"))
editing_keymap.bind("", "!Backspace", Func("finalize_mark").bind("^+{Left}^x"))

;; Yank
editing_keymap.bind("", "^y", Func("finalize_mark").bind("^v"))

;; Undo/redo
editing_keymap.remap("", "^/", "^z")
editing_keymap.remap("", "^!/", "^y")

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
