;;;; AutoHotkey script of Aaron Harris
;;;; EXIT
;;;;====================================================================

;;; This file defines a family keymap that uses `C-x C-c` to close the
;;; application.

exit_keymap := new Keymap("Exit keymap", null, "family")
exit_keymap.bind("", "^x", Func("prefix_key"))
exit_keymap.remap("^x", "^c", "!{F4}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto exit_include
;;;;====================================================================

;;;;====================================================================
;;;; End exit.ahk
exit_include:
;;;;====================================================================