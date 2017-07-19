;;;; AutoHotkey script of Aaron Harris
;;;; KEYMAPS
;;;;====================================================================

;; This file contains support for Emacs-style prefix keys.

;; The current prefix, represented as a string of hotkeys.  For example,
;; if `C-x` is a known prefix key, then after pressing `C-x`, the prefix
;; will be the string "^x".
prefix := ""

;; The global keymap.
global_keymap := new Keymap()
global_keymap.default_action := Func("self_insert")

hello() {
	MsgBox "Hello!"
}

;; A list of all hotkeys we want to use in our keymap.  No effort is made
;; to support non-US keyboard layouts.
all_keys := [
	, "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"
	, "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
	, "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
	, "``", "-", "=", "[", "]", "\", ";", "'", ",", ".", "/"
	, "Space", "Tab", "Enter", "Esc", "Backspace"
	, "Del", "Ins", "Home", "End", "PgUp", "PgDn"
	, "Up", "Down", "Left", "Right"
	, "Numpad1", "Numpad2", "Numpad3", "Numpad4", "Numpad5"
	, "Numpad6", "Numpad7", "Numpad8", "Numpad9", "Numpad0"
	, "NumpadAdd", "NumpadSub", "NumpadMult", "NumpadDiv"
	, "NumpadDot", "NumpadEnter", "NumpadClear"
	, "NumpadDel", "NumpadIns", "NumpadHome", "NumpadEnd"
	, "NumpadUp", "NumpadDown", "NumpadLeft", "NumpadRight"
	, "F1", "F2", "F3", "F4", "F5", "F6"
	, "F7", "F8",	"F9", "F10", "F11", "F12"]

;; A list of all modifier keys, and their most common combinations.
all_modifiers := [ ""
	, "^", "!", "+", "#"
	, "^+", "^!", "!+", "^!+"]

;; Hotkeys we don't want to use the keymap for, to work around some kind
;; of technical limitation.
blacklist := {"#s": true}

;; Make all hotkeys use the global keymap.
for _, key in all_keys {
	for _, modifier in all_modifiers {
		hkey := modifier . key
		if (!blacklist[hkey]) {
			;; Commented out temporarily, until this feature is less buggy.
			;; Hotkey % modifier . key, keymap_lookup
		}
	}
}

;;;;====================================================================
;;;; End Auto-Execute Section
Goto keymap_include
;;;;====================================================================

class Keymap {
	__New() {
		this[""] := {}
	}
	
	;; Return true if the keymap should be active right now.
	;;
	;; Note that this method does not take the current prefix into
	;; account, so that overrides for this method don't need to
	;; re-implement the prefix-handling logic.
	isActive() {
		return true
	}
	
	;; Default action to take for keys with no binding.
	;;
	;; Return true if this action should be considered as consuming the
	;; hotkey; if false is returned, then lower-priority keymaps are
	;; consulted, and any bindings present in them may still be called.
	;;
	;; The default implementation is to do nothing and return false.
	default_action(key) {
		return false
	}
	
	;; Execute the command associated with the given prefix and key.
	;;
	;; If the keymap is active and has a binding for A_ThisHotkey,
	;; execute that command and then return true.  Otherwise, do nothing
	;; and return false.
	lookup(prefix, key) {
		binding := this[prefix][key]
		
		if (binding) {
			binding.call()
			return true
		} else {
			this.default_action(key)
		}
	}

	;; Associate the given key (or key sequence, if a prefix is supplied)
	;; with a command in this keymap.
	bind(prefix, key, command) {
		this[prefix][key] := command
	}
	
}

;; Wrap key names in braces, for use with Send.
brace_key(key) {
	return RegExReplace(key, "([!+#^]*)(.+)", "$1{$2}")
}

;; Execute the command associated with A_ThisHotkey in the global
;; keymap.
keymap_lookup() {
	global prefix
	global global_keymap
	
	key := brace_key(A_ThisHotkey)
	global_keymap.lookup(prefix, key)
}

;; Send key, ignoring any possible hotkeys.
;;
;; Ignore the first parameter (an object reference, so this function
;; can be used as an object method).
;;
;; This is the default action for the global keymap, so that keys retain
;; their usual behavior when there is no specific binding for them.
self_insert(_this, key) {
	Suspend On
	Send % key
	Suspend Off
}

;;;;====================================================================
;;;; End keymap.ahk
keymap_include:
;;;;====================================================================
