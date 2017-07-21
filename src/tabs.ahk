;;;; AutoHotkey script of Aaron Harris
;;;; TABS
;;;;====================================================================

;; This file defines a family keymap with hotkeys for manipulating tabs.
;;
;; In order to participate in this family, an app should use these keys
;; for tab navigation:
;;
;; `C-<tab>` for "next tab"
;; `C-S-<tab>` for "previous tab"
;; `A-S-<next>` for "move current tab forward"
;; `A-S-<prior>` for "move current tab backward"

#include keymap.ahk

;; The keymap.  This is temporarily hard-coded to Firefox until a
;; mechanism for registering apps with a family keymap is devised.
tabs_keymap := new Keymap(null, "family")

;; Use `C-[` and `C-]` to navigate between tabs.
tabs_keymap.remap("", "^[", "{Blind}^+{Tab}")
tabs_keymap.remap("", "^]", "{Blind}^{Tab}")

;; Use `M-[` and `M-]` to rearrange tabs.
tabs_keymap.remap("", "![", "^+{PgUp}")
tabs_keymap.remap("", "!]", "^+{PgDn}")

;;;;====================================================================
;;;; End Auto-Execute Section
Goto tabs_include
;;;;====================================================================

;;;;====================================================================
;;;; End tabs.ahk
tabs_include:
;;;;====================================================================