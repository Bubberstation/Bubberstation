/datum/keybinding/mob/pixel_tilting
	hotkey_keys = list("N")
	name = "Pixel Tilting"
	full_name = "Pixel Tilt"
	description = "Shift a mob's rotational value"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXEL_TILT_DOWN

/datum/keybinding/mob/pixel_tilting/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_tilt)

/datum/keybinding/mob/pixel_tilting/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_TILT_UP)
