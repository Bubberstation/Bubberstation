#define AGILITY_DEFAULT_COOLDOWN_TIME 4 SECONDS
#define AGILITY_MODE_ABOVE "agility_mode_above"
#define AGILITY_MODE_BELOW "agility_mode_below"
#define AGILITY_MODE_IGNORE "agility_mode_ignore"

/datum/action/cooldown/raptor/agility
	name = "Toggle agility"
	desc = "Toggle you agility"
	cooldown_time = AGILITY_DEFAULT_COOLDOWN_TIME
	current_mode = AGILITY_MODE_IGNORE
	button_icon_state = AGILITY_MODE_IGNORE

/datum/action/cooldown/raptor/agility/Activate(atom/target)
	. = ..()

	if(current_mode == AGILITY_MODE_IGNORE)
		update_button_state(AGILITY_MODE_ABOVE)
		owner.balloon_alert(owner, "Moving above!")
		passtable_on(owner, INNATE_TRAIT)
		current_mode = AGILITY_MODE_ABOVE

	else if(current_mode == AGILITY_MODE_ABOVE)
		update_button_state(AGILITY_MODE_IGNORE)
		owner.balloon_alert(owner, "Ignoring!")
		passtable_off(owner, INNATE_TRAIT)
		current_mode = AGILITY_MODE_IGNORE

	return TRUE

#undef AGILITY_DEFAULT_COOLDOWN_TIME
#undef AGILITY_MODE_ABOVE
#undef AGILITY_MODE_BELOW
#undef AGILITY_MODE_IGNORE

