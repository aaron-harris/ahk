;;;; AutoHotkey script of Aaron Harris
;;;; PREFIX ARGUMENTS
;;;;====================================================================

;; This file contains support for Emacs-style prefix arguments in
;; other applications.

;;; Entering prefix arguments
;;;==========================
cx_prefix := 0  ; Prefix key C-x has been entered.
prefix_arg := {state: "universal", value: 1}  ; Prefix argument state.

;; Supply one digit of a prefix argument (Emacs `C-<N>` for <N> in 0-9).
supply_digit(n) {
    global prefix_arg
    if (prefix_arg["state"] = "negation") {
        prefix_arg := {state: "numeric", value: -n}
    } else if (prefix_arg["state"] != "numeric") {
        prefix_arg := {state: "numeric", value: n}
    } else if (prefix_arg["value"] < 0) {
        prefix_arg["value"] := (10 * prefix_arg["value"]) - n
    } else {
        prefix_arg["value"] := (10 * prefix_arg["value"]) + n
    }
}

;; Negate prefix argument (Emacs `C--`).
negate_prefix() {
    global prefix_arg
    if (prefix_arg["state"] = "numeric") {
        prefix_arg["value"] := -prefix_arg["value"]
    } else if (prefix_arg["state"] = "negation") {
        prefix_arg := {state: "universal", value: 1}
    } else {
        prefix_arg := {state: "negation", value: -1}
    }
}

;; Universal prefix argument (Emacs `C-u`)
universal_prefix() {
    global prefix_arg
    if (prefix_arg["state"] = "universal") {
        prefix_arg["value"] := 4*prefix_arg["value"]
    } else if (prefix_arg["state"] = "negation") {
        prefix_arg := {state: "universal", value: -4}
    }
    ;; Do nothing if state is "numeric"
}

;; Reset prefix argument to initial state (Emacs `C-g`, and called
;; whenever a key consumes the prefix).
reset_prefix() {
    global prefix_arg
    prefix_arg := {state: "universal", value: 1}
}

;;; Use and manipulation of prefix arguments
;;;=========================================
    
;; Set the magnitude of the prefix argument as specified, but do not
;; change sign.
set_prefix_magnitude(n) {
    global prefix_arg
    (prefix_arg["value"] < 0)
        ? prefix_arg["value"] := -n
        : prefix_arg["value"] := n
}
    
;; Subroutine to treat a prefix arg as generic repetition.
repeat_by_prefix(action, opp_action := "reset_prefix", args*) {
    global prefix_arg
    if (prefix_arg["value"] < 0) {
        n := -prefix_arg["value"]
        action := opp_action 
    } else {
        n := prefix_arg["value"]
    }
    reset_prefix()
    loop %n% {
        %action%(args*)
    }
}

;; Subroutine to handle "opposite pair" actions, like `C-b` and `C-f`.
invert_by_prefix(action, opp_action, args*) {
    global prefix_arg
    if (prefix_arg["value"] < 0) {
        action := opp_action
    }
    reset_prefix()
    %action%(args*)
}

;;; Use of C-x prefix
;;;==================

;; Call action with args if the C-x prefix has been used ("consuming"
;; that prefix), and send the hotkey that triggered this call
;; otherwise.
with_Cx(action, args*) {
    global cx_prefix
    key := A_ThisHotKey
    if (cx_prefix = 1) {
        cx_prefix := 0
        %action%(args*)
    } else {
		insert(this, key)
    }
}

;;;;====================================================================
;;;; End Auto-Execute Section
Goto prefix_include
;;;;====================================================================

;; `C-x` prefix hotkey.
~^x::
    cx_prefix := 1
    return

;; Abort hotkey, bound to both `C-g` and `C-x C-g`.
~^g::
    cx_prefix := 0
    reset_prefix()
    return

;;;;====================================================================
;;;; End prefix.ahk
prefix_include:
;;;;====================================================================
