/datum/keybinding/mob/tilt_right
	hotkey_keys = list("AltCtrlEast", "AltCtrlD")
	name = "pixel_tilt_east"
	full_name = "Pixel Tilt Right"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELTILT_LEFT

/datum/keybinding/mob/tilt_right/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.tilt_right()
	return TRUE

/datum/keybinding/mob/tilt_left
	hotkey_keys = list("AltCtrlWest", "AltCtrlA")
	name = "pixel_tilt_west"
	full_name = "Pixel Tilt Left"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELTILT_RIGHT

/datum/keybinding/mob/tilt_left/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	M.tilt_left()
	return TRUE
