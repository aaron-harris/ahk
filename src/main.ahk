;;;; AutoHotkey script of Aaron Harris
;;;; MAIN SCRIPT
;;;;====================================================================

#NoEnv
#SingleInstance force
SendMode Input

;; We assume here that this file is in the current include directory.
;; If we were less trusting of our bootstrapper, we could make this so
;; with the directive
;;
;;   #Include %A_LineFile%\..
;;
;; but this would cause AHK Studio to display an erroneous, empty
;; include that I find ugly and distracting.

#Include remap.ahk
#Include keymap.ahk
#Include windows.ahk
#Include meta.ahk
#Include emacs.ahk
#Include firefox.ahk
#Include mediamonkey.ahk

#Include explorer.ahk