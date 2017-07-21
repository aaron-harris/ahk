;;;; AutoHotkey script of Aaron Harris
;;;; FIREFOX FEATURES
;;;;====================================================================

;;; This file contains hotkeys and hotstrings for use in Firefox.

firefox_context := "ahk_class MozillaWindowClass"
firefox_keymap := new Keymap(firefox_context)

;; Use `C-[` and `C-]` to navigate between tabs.
firefox_keymap.remap("", "^[", "{Blind}^+{Tab}")
firefox_keymap.remap("", "^]", "{Blind}^{Tab}")

;; Use `M-[` and `M-]` to rearrange tabs.
firefox_keymap.remap("", "![", "^+{PgUp}")
firefox_keymap.remap("", "!]", "^+{PgDn}")

;; Bind `M-p` and `M-n` to up and down, for scrolling.
firefox_keymap.remap("", "!p", "{Up}")
firefox_keymap.remap("", "!n", "{Down}")

;; Use `M-g` for refresh.
firefox_keymap.remap("", "!g", "{F5}")

;; Use `M-x` to select the address bar.
firefox_keymap.remap("", "!x", "{F6}")

;; Use `C-x 1` and `C-x 0` for "close other tabs" and "close this tab".
;; The `C-x 1` hotkey requires this Firefox addon to work:
;;   https://addons.mozilla.org/en-US/firefox/addon/close-other-tabs/
firefox_keymap.bind("", "^x", Func("prefix_key"))
firefox_keymap.bind("^x", "1", Func("close_other_tabs"))
firefox_keymap.remap("^x", "0", "^{F4}")

;; Register with appropriate family keymaps.
for _, keymap in [
		, editing_keymap
		, tabs_keymap] {
	keymap.addContext(firefox_context)
}

;;;;====================================================================
;;;; End Auto-Execute Section
Goto firefox_include
;;;;====================================================================

close_other_tabs() {
    box_type := 1+32  ; 1 for OK/Cancel, 32 for query icon
    MsgBox, % box_type, Close Tabs, Close other tabs?
    IfMsgBox, OK
      Send ^+{F4}
}

;;;;====================================================================
;;;; End firefox.ahk
firefox_include:
;;;;====================================================================
