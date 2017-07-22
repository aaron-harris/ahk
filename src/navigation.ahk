;;;; AutoHotkey script of Aaron Harris
;;;; NAVIGATION HOTKEYS
;;;;====================================================================

;;; This file defines a family keymap for Emacs-style navigation keys,
;;; including "transient mark"-style selection.

navigation_keymap := new Keymap(null, "family")

;; Whether there is an active region at the moment.
mark := false

;; `C-x` prefix key
navigation_keymap.bind("", "^x", Func("prefix_key"))

;; Navigation
navigation_keymap.bind("", "^b", Func("shift_select").bind("{Left}"))
navigation_keymap.bind("", "^f", Func("shift_select").bind("{Right}"))
navigation_keymap.bind("", "^p", Func("shift_select").bind("{Up}"))
navigation_keymap.bind("", "^n", Func("shift_select").bind("{Down}"))
navigation_keymap.bind("", "^a", Func("shift_select").bind("{Home}"))
navigation_keymap.bind("", "^e", Func("shift_select").bind("{End}"))
navigation_keymap.bind("", "!b", Func("shift_select").bind("^{Left}"))
navigation_keymap.bind("", "!f", Func("shift_select").bind("^{Right}"))
navigation_keymap.bind("", "!+,", Func("shift_select").bind("^{Home}"))
navigation_keymap.bind("", "!+.", Func("shift_select").bind("^{End}"))

;; Selection
navigation_keymap.remap("^x", "h", "^a")
navigation_keymap.bind("", "^Space", Func("set_mark"))
navigation_keymap.bind("", "^g", Func("clear_selection"))

;;;;====================================================================
;;;; End Auto-Execute Section
Goto navigation_include
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
;; determines which such workaround to use.  The options are as follows:
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

;;;;====================================================================
;;;; End navigation.ahk
navigation_include:
;;;;====================================================================
