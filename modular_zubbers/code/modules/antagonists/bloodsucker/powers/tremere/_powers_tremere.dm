/**
 *	# Tremere Powers
 *
 *	This file is for Tremere power procs and Bloodsucker procs that deals exclusively with Tremere.
 *	Tremere has quite a bit of unique things to it, so I thought it's own subtype would be nice
 */

/datum/action/cooldown/bloodsucker/targeted/tremere
	name = "Tremere Gift"
	desc = ""
	power_explanation = ""
	active_background_icon_state = "tremere_power_on"
	base_background_icon_state = "tremere_power_off"
	button_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'
	background_icon = 'modular_zubbers/icons/mob/actions/tremere_bloodsucker.dmi'

	// Tremere powers don't level up, we have them hardcoded.
	level_current = 0
	// Re-defining these as we want total control over them
	power_flags = BP_AM_TOGGLE|BP_AM_STATIC_COOLDOWN
	purchase_flags = TREMERE_CAN_BUY
	// Targeted stuff
	unset_after_click = FALSE

/datum/action/cooldown/bloodsucker/targeted/tremere/on_power_upgrade()
	if(base_background_icon_state != "tremere_power_gold_off" && level_current > 4)
		background_icon_state = "tremere_power_gold_off"
		active_background_icon_state = "tremere_power_gold_on"
		base_background_icon_state = "tremere_power_gold_off"
	. = ..()
