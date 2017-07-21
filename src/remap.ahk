;;;; AutoHotkey script of Aaron Harris
;;;; GLOBAL REMAPPINGS
;;;;====================================================================

;;; This file contains basic, global remappings.

;;;;====================================================================
;;;; End Auto-Execute Section
Goto remap_include
;;;;====================================================================

;; Use double-shift for caps lock.
<+RShift::CapsLock
>+LShift::CapsLock

;; Use caps lock as control key.
;;
;; For most machines, this will be handled by the registry instead
;; (and this hotkey will be ignored, since there is no way for the
;; keyboard to send the CapsLock key.)
#InputLevel 1
CapsLock::LCtrl
#InputLevel 0

;; Add extra mapping for apps key.
#`::AppsKey

;;;;====================================================================
;;;; End remap.ahk
remap_include:
;;;;====================================================================