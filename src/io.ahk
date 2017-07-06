;;;; AutoHotkey script of Aaron Harris
;;;; INPUT/OUTPUT LIBRARY
;;;;====================================================================

;; This file contains commands for sending data to and receiving data
;; from the user.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto io_include
;;;;====================================================================

;;; Basic input
;;;============
;; Input the specified key sequence.
;; This is useful if we want to use `Send` as a function parameter.
input(keys) {
    Send %keys%
}

;; Input with movement commands reversed.
opp_input(keys) {
    ;; The carats are necessary because we have "replacement loops",
    ;; so we need to be careful to not immediately undo each
    ;; replacement.
    dict := { "{Up}":    "{Down^}"
            , "{Down}":  "{Up^}" 
            , "{Left}":  "{Right^}"
            , "{Right}": "{Left^}"
            , "{PgUp}":  "{PgDn^}"
            , "{PgDn}":  "{PgUp^}"}
    for key, opp_key in dict {
        keys := StrReplace(keys, key, opp_key) 
    }
    ;; Stripping the escape carats:
    keys := RegExReplace(keys, "\{(.*?)\^}", "{$1}")
    input(keys)
}

;;; Message dialogs
;;;================
;; Display message dialog with specified prompt.
;; This is useful if we want to use `MsgBox` as a function parameter.
message(text) {
    MsgBox %text%
}

;;;;====================================================================
;;;; End io.ahk
io_include:
;;;;====================================================================
