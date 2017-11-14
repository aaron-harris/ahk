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

;; Establish pass-through keys for Saka Key extension.  Saka accepts key
;; sequences directly, so we don't need to translate keys for it, but
;; AHK prefix keys are swallowed, so we can't use the same prefix key
;; (here, `C-x`, which is also used as a prefix  by the exit family) in
;; both AHK and Saka without wiring AHK to re-emit the prefix key as
;; necessary.
firefox.bind("", "^x", Func("prefix_key"))
firefox.keymap.remap("^x", "0", "^x0")  ;; Close this tab
firefox.keymap.remap("^x", "1", "^x1")  ;; Close other tabs
firefox.keymap.remap("^x", "3", "^x3")  ;; Duplicate tab

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
