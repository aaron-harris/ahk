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

;; Core functionality
#Include remap.ahk
#Include keymap.ahk

;; Global functionality
#Include meta.ahk
#Include windows.ahk
#Include emacs.ahk

;; App families
#Include family/navigation.ahk
#Include family/editing.ahk
#Include family/exit.ahk
#Include family/tabs.ahk

;; App-specific functionality
#Include app/ahk_studio.ahk
#Include app/explorer.ahk
#Include app/firefox.ahk
#Include app/mediamonkey.ahk
#Include app/notepad.ahk
#Include app/texniccenter.ahk
