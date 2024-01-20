/datum/action/cooldown/raptor
	button_icon = 'modular_zubbers/icons/UI_icons/Actions/actions_raptor.dmi'
	var/current_mode

/datum/action/cooldown/raptor/IsAvailable(feedback)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/human/tesh = owner
	if(isdead(tesh))
		return FALSE

/datum/action/cooldown/raptor/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()
