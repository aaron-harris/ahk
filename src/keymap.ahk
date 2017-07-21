﻿;;;; AutoHotkey script of Aaron Harris
;;;; KEYMAPS
;;;;====================================================================

;;; This file contains support for Emacs-style keymaps.  The main
;;; purpose is to enable multiple-stroke key sequences as hotkeys, but
;;; enabling this requires routing all possible hotkeys (or nearly all)
;;; through the keymap structure.  Additional features (like numeric
;;; prefixes and transient mark support) will be added to this
;;; structure in the future.


;; The current prefix object.  It has the following properties:
;;
;; keys: The current key prefix.  For instance, if `C-x` has just been
;;   pressed, and `C-x` is a known prefix key, this will be the string
;;   "^x".  Keys are expressed in the same format as `A_ThisHotkey` and
;;   are delimited by spaces.
;;
;; next: The key prefix that will be used for the next command.  This
;;   value is set by commands that manipulate the prefix, so the code
;;   that resets the prefix after each keymap lookup will preserve their
;;   changes.
prefix := {keys: "", next: ""}

;; The global keymap.
global_keymap := new Keymap("A", false)
global_keymap.default_action := Func("insert")

;; The array of local keymaps.
local_keymaps := []

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
;;
;; #s - Suspend hotkey needs to be native so it doesn't suspend itself.
;; !Tab, !+Tab - Alt-tab functionality is tetchy when handled in a keymap.
blacklist := {"#s": true, "!Tab": true, "!+Tab": true}

;; Make all hotkeys use the global keymap.
for _, key in all_keys {
	for _, modifier in all_modifiers {
		hkey := modifier . key
		if (!blacklist[hkey]) {
			;; Commented out temporarily, until this feature is less buggy.
			Hotkey % modifier . key, keymap_lookup
		}
	}
}

global_keymap.bind("", "F12", Func("prefix_key"))
global_keymap.bind("F12", "F12", Func("hello"))

global_keymap.list_all()

hello() {
	MsgBox % "Hello!"
}

;;;;====================================================================
;;;; End Auto-Execute Section
Goto keymap_include
;;;;====================================================================

class Keymap {
	
	;; Associative array mapping prefixes to key bindings.
	bindings := {"": {}}
	
	;; Context in which this keymap should be active.
	context := "A"
	
	;; Construct an empty keymap.
	;;
	;; If the context parameter is supplied, the keymap is contextual
	;; and will only be active when that context is in effect, as
	;; determined by the `winActive` function (the context parameter is
	;; a `winTitle` string).
	;;
	;; If the register parameter is true (or omitted), add this keymap
	;; to the list of local keymaps.
	__New(context := "A", register := true) {
		global local_keymaps
		
		this.context := context
		
		if (register) {
			local_keymaps.push(this)
		}
	}
	
	;; Return true if the keymap should be active right now.
	isActive() {
		return winActive(this.context)
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
	;; Return true if this action should be considered as consuming the
	;; hotkey; if false is returned, then lower-priority keymaps are
	;; consulted, and any bindings present in them may still be called.
	;;
	;; If the keymap is inactive, do nothing and return false.  If the
	;; keymap is active but doesn't have a binding for this key, perform
	;; the default action as given by the `default_action` method.
	lookup(prefix, key) {
		if !(this.isActive()) {
			return false
		}
		
		binding := this.bindings[prefix][key]
		if (binding) {
			binding.call()
			return true
		}
		
		return this.default_action(key)
	}
	
	;; Associate the given key (or key sequence, if a prefix is supplied)
	;; with a command in this keymap.
	bind(prefix, key, command) {
		if !(this.bindings[prefix]) {
			this.bindings[prefix] := {}
		}
		this.bindings[prefix][brace_key(key)] := command
	}
	
	;; Remap the given key or key sequence to a new key sequence.
	;;
	;; Note that this is not the same thing as remapping a key in Emacs;
	;; the remapping will bypass not only other keymap bindings, but
	;; also ordinary hotkey definitions.  It's just a convenient way to
	;; bind a key sequence to the `Send` command.
	remap(prefix, key, newKeys) {
		this.bind(prefix, key, Func("insert").bind(this, newKeys))
	}
}

;; Wrap key names in braces, for use with Send.
brace_key(key) {
	return RegExReplace(key, "([!+#^]*)(.+)", "$1{$2}")
}

;; Execute the command associated with A_ThisHotkey in the currently
;; active keymaps.  Try local keymaps first, then the global keymap,
;; and stop when any keymap's `lookup` method returns true (indicating
;; that the key has been consumed).
keymap_lookup() {
	global prefix
	global global_keymap
	global local_keymaps
	
	key := brace_key(A_ThisHotkey)
	
	for _, map in local_keymaps {
		if (map.lookup(prefix.keys, key)) {
			clean_prefix()
			return
		}
	}
	
	global_keymap.lookup(prefix.keys, key)
	clean_prefix()
}

;; Insert keys, ignoring any possible hotkeys.
;;
;; Note that this method, unlike `Send`, is Capslock-sensitive.
;;
;; Ignore the first parameter (an object reference, so this function
;; can be used as an object method).
insert(_this, keys) {
	Suspend On
	SetStoreCapslockMode Off
	Send % keys
	SetStoreCapslockMode On
	Suspend Off
}

;; Add `A_ThisHotkey` to the current prefix.
;;
;; Registering this command in a keymap creates a prefix map.
prefix_key() {
	global prefix
	
	key := A_ThisHotkey
	spacer := (prefix.keys == "") ? "" : " "
	
	prefix.next := prefix.keys . spacer . key
}

;; Reset the current prefix.
clean_prefix() {
	global prefix
	
	prefix.keys := prefix.next
	prefix.next := ""
}

;;;;====================================================================
;;;; End keymap.ahk
keymap_include:
;;;;====================================================================
