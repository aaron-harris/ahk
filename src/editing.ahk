;;;; AutoHotkey script of Aaron Harris
;;;; EDITING HOTKEYS
;;;;====================================================================

;;; This file defines a family keymap for Emacs-style editing keys.

editing_keymap := new Keymap(null, "family")

;; Whether there is an active region at the moment.
mark := false

;; `C-x` prefix key
editing_keymap.bind("", "^x", Func("prefix_key"))

;; Navigation
editing_keymap.bind("", "^b", Func("shift_select").bind("{Left}"))
editing_keymap.bind("", "^f", Func("shift_select").bind("{Right}"))
editing_keymap.bind("", "^p", Func("shift_select").bind("{Up}"))
editing_keymap.bind("", "^n", Func("shift_select").bind("{Down}"))
editing_keymap.bind("", "^a", Func("shift_select").bind("{Home}"))
editing_keymap.bind("", "^e", Func("shift_select").bind("{End}"))
editing_keymap.bind("", "!b", Func("shift_select").bind("^{Left}"))
editing_keymap.bind("", "!f", Func("shift_select").bind("^{Right}"))
editing_keymap.bind("", "!+,", Func("shift_select").bind("^{Home}"))
editing_keymap.bind("", "!+.", Func("shift_select").bind("^{End}"))

;; Selection
editing_keymap.remap("^x", "h", "^a")
editing_keymap.bind("", "^Space", Func("set_mark"))
editing_keymap.bind("", "^g", Func("clear_selection"))

;; Editing
editing_keymap.remap("", "^o", "{Enter}{Left}")

;; Kill/delete
editing_keymap.remap("", "^d", "{Delete}")
editing_keymap.remap("", "!d", "^+{Right}^x")
editing_keymap.bind("", "^w", Func("kill_region"))
editing_keymap.bind("", "!w", Func("copy_region"))
editing_keymap.bind("", "^k", Func("kill_line"))

;; Yank
editing_keymap.remap("", "^y", "^v")

;; Undo
editing_keymap.remap("", "^/", "^z")

;; Minor apps in this family:
editing_keymap.addContext("ahk_class Notepad")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto editing_include
;;;;====================================================================

;; With no argument (or a truthy argument), activate the region, so that
;; subsequent navigation commands select text.  With a falsey argument,
;; deactivate the region.
set_mark(value := true) {
	global mark
	mark := value
}

;; Input the given keys; use shift to select text if the mark is active.
shift_select(keys) {
	global mark
	
	shift_it := (mark) ? "+" : ""
	insert(this, shift_it . keys)
}

;; Clear the current text selection.
;;
;; Since most applications don't have a built-in "clear selection"
;; command, we must use some kind of workaround.  The `method` parameter
;; determines which such workaround to use.  The options are as follows:
;;
;; "mouse", or omitted:
;;   Attempt to click on the caret.
;;
;; "paste":
;;   Delete and re-insert the selected text.  Note that this method will
;;   move the caret to the end of the selection, even if it was at the
;;   beginning.
clear_selection(method := "mouse") {
	set_mark(false)
	
	;; If there's no selection, we don't need to do anything anyway.
	ControlGet, selText, Selected
	if (selText == "") {
		return
	}

	if (method == "mouse") {
		MouseGetPos, x, y
		MouseMove, %A_CaretX%, %A_CaretY%, 0
		Click %A_CaretX%, %A_CaretY%
		MouseMove, x, y, 0
	}
	
	if (method == "paste") {
		insert(this, "{Delete}")
		SendRaw % selText
	}
}

;; Copy the region and then de-select it, as in Emacs.
copy_region() {
	insert(this, "^c")
	clear_selection()
}

;; Cut the region and deactivate the mark.
kill_region() {
	insert(this, "^x")
	set_mark(false)
}

;; Cut until the end of the line and deactivate the mark.
kill_line() {
	insert(this, "+{End}^x")
	set_mark(false)
}

;;;;====================================================================
;;;; End meta.ahk
editing_include:
;;;;====================================================================
