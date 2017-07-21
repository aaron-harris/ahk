;;;; AutoHotkey script of Aaron Harris
;;;; EMACS HOTKEYS
;;;;====================================================================

;;; This file contains functionality related to control of Emacs.

;; The cygwin directory.  Set via the CYGWIN environment variable.
;; Defaults to "C:\cygwin64".
EnvGet, cygwin, CYGWIN
if (cygwin = "") {
    cygwin := "C:\cygwin64"
}

;; The path to bash.
bash := cygwin . "\bin\bash.exe"

;; The path to my home directory.
home := cygwin . "\home\Aaron"

;; Function to execute a command in bash.
call_bash(command) {
    global bash, home
    Run, %bash% -l -c "%command%"
       , %home%
       , Hide
}

;; Function to execute code in Emacs.  This will open a new
;; emacsclient frame, focus that frame, and evaluate FORMS.  Since
;; FORMS are wrapped in a `progn` form, multiple forms will be
;; executed in sequence.
;;
;; Note that FORMS are wrapped in bash string-literal syntax, so both
;; single- and double-quotes should be escaped with backslashes (on
;; top of doubling double quotes for AHK).
call_emacs(forms := "") {
    call_bash("emacsclient -a \""\"" -c -n -q -e "
              . "$'(progn (raise-frame) " . forms . ")'")
}

;; This keybinding opens a new emacsclient frame on the current
;; desktop.  Note that this keybinding overrides the default Windows
;; binding for `#e`, which opens File Explorer.
global_keymap.bind("", "#e", Func("call_emacs"))

;;; Capture
;;;========
;; This keybinding triggers Org mode capture using emacsclient.  This
;; overrides the default Windows binding for Win+c, which launches
;; Cortana.
global_keymap.bind("", "#c"
	, Func("call_emacs").bind("(org-display-capture-in-whole-frame)"))

;;;;====================================================================
;;;; End Auto-Execute Section
Goto emacs_include
;;;;====================================================================

;;;;====================================================================
;;;; End emacs.ahk
emacs_include:
;;;;====================================================================
