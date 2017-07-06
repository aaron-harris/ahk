;;;; AutoHotkey script of Aaron Harris
;;;; FIREFOX FEATURES
;;;;====================================================================

;; This file contains hotkeys and hotstrings for use in Firefox.

#Include io.ahk
#Include prefix.ahk

;;;;====================================================================
;;;; End Auto-Execute Section
Goto firefox_include
;;;;====================================================================

#IfWinActive ahk_class MozillaWindowClass

;; Use `C-[` and `C-]` to navigate between tabs.
^[::Send {Blind}^+{Tab}
^]::Send {Blind}^{Tab}

;; Use `M-[` and `M-]` to rearrange tabs.
![::Send ^+{PgUp}
!]::Send ^+{PgDn}

;; Bind `M-p` and `M-n` to up and down, for scrolling.
!p::Send {Up}
!n::Send {Down}

;; Use `M-g` for refresh.
!g::Send {F5}

;; Use `M-x` to select the address bar.
!x::Send {F6}

;; Use `C-x 1` for "close other tabs", using this addon:
;;   https://addons.mozilla.org/en-US/firefox/addon/close-other-tabs/
close_other_tabs() {
    box_type := 1+32  ; 1 for OK/Cancel, 32 for query icon
    MsgBox, % box_type, Close Tabs, Close other tabs?
    IfMsgBox, OK
      Send ^+{F4}
    return
}
1::
    with_Cx("close_other_tabs")
    return

;; Use `C-x 0` for "close this tab"
close_this_tab() {
    Send ^{F4}
    return
}
0::
    with_Cx("close_this_tab")
    return

#IfWinActive

;;;;====================================================================
;;;; End firefox.ahk
firefox_include:
;;;;====================================================================
