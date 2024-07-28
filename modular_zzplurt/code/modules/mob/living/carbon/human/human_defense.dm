/mob/living/carbon/human/proc/set_combat_focus(new_mode, silent = TRUE)
	if(focus_mode == new_mode)
		return

	. = focus_mode
	focus_mode = new_mode
	hud_used?.focus_toggle?.update_appearance()

	var/focus_sound = client?.prefs.read_preference(/datum/preference/toggle/sound_combatmode)
	if(focus_mode)
		face_mouse = !!client?.prefs?.read_preference(/datum/preference/toggle/face_cursor_combat_mode)
		set_combat_indicator(TRUE)
		if(focus_sound)
			SEND_SOUND(src, sound('sound/misc/ui_togglecombat.ogg', volume = 25)) //Sound from interbay!
	else
		face_mouse = FALSE
		set_combat_indicator(FALSE)
		if(focus_sound)
			SEND_SOUND(src, sound('sound/misc/ui_toggleoffcombat.ogg', volume = 25)) //Slightly modified version of the above

