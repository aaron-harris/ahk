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
#Include navigation.ahk
#Include editing.ahk
#Include exit.ahk
#Include tabs.ahk

;; App-specific functionality
#Include ahk_studio.ahk
#Include explorer.ahk
#Include firefox.ahk
#Include mediamonkey.ahk
