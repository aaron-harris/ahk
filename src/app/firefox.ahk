;;;; AutoHotkey script of Aaron Harris
;;;; FIREFOX FEATURES
;;;;====================================================================

;;; This file contains hotkeys and hotstrings for use in Firefox.

firefox := new App("Firefox", "ahk_exe firefox.exe"
	, editing_keymap
	, exit_keymap
	, tabs_keymap)

;; Use `C-[` and `C-]` to navigate between tabs.
firefox.keymap.remap("", "^[", "{Blind}^+{Tab}")
firefox.keymap.remap("", "^]", "{Blind}^{Tab}")

;; Use `M-[` and `M-]` to rearrange tabs.
firefox.keymap.remap("", "![", "^+{PgUp}")
firefox.keymap.remap("", "!]", "^+{PgDn}")

;; Bind `M-p` and `M-n` to up and down, for scrolling.
firefox.keymap.remap("", "!p", "{Up}")
firefox.keymap.remap("", "!n", "{Down}")

;; Use `M-g` for refresh.
firefox.keymap.remap("", "!g", "{F5}")

;; Use `M-x` to select the address bar.
firefox.keymap.remap("", "!x", "{F6}")

;; Use `C-x 0` for "close this tab"
firefox.keymap.bind("", "^x", Func("prefix_key"))
firefox.keymap.remap("^x", "0", "^{F4}")

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
