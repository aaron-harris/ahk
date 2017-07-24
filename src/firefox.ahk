;;;; AutoHotkey script of Aaron Harris
;;;; FIREFOX FEATURES
;;;;====================================================================

;;; This file contains hotkeys and hotstrings for use in Firefox.

firefox_context := "ahk_exe firefox.exe"
firefox_keymap := new Keymap(firefox_context)
register_context(firefox_context, [
	, editing_keymap
	, exit_keymap
	, tabs_keymap])

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

;; Tab manipulation commands:
;; `C-x 0`: "close this tab"
;; `C-x 1`: "close other tabs" uses this addon:
;;   https://addons.mozilla.org/en-US/firefox/addon/close-other-tabs/
;; `C-x 3`: "duplicate tab" uses this addon:
;;   https://addons.mozilla.org/en-US/firefox/addon/duplicate-tab-hotkey/
firefox_keymap.bind("", "^x", Func("prefix_key"))
firefox_keymap.remap("^x", "0", "^{F4}")
firefox_keymap.bind("^x", "1", Func("close_other_tabs"))
firefox_keymap.remap("^x", "3", "^k")

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
