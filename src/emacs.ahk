;;;; AutoHotkey script of Aaron Harris
;;;; EMACS HOTKEYS
;;;;====================================================================

;;; This file contains functionality related to control of Emacs.

;; Hack so that preceding "include" label doesn't point at a function.
not_a_label = true

;; Open a new Emacs client
emacs(forms = "") {
	Run, emacsclient -a "" -c -n -q -e "(progn (raise-frame) %forms%)"
}

;;;;====================================================================
;;;; End Auto-Execute Section
Goto emacs_include
;;;;====================================================================

#e::emacs()

;;;;====================================================================
;;;; End emacs.ahk
emacs_include:
;;;;====================================================================
