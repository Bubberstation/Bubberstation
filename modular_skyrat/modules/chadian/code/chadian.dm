#define RESTING_STATE_NONE 0
#define RESTING_STATE_SIT 1
#define RESTING_STATE_REST 2

/mob/living/basic/pet/dog/corgi/ian
	icon = 'modular_skyrat/modules/chadian/icons/ian.dmi'
	ai_controller = /datum/ai_controller/basic_controller/dog/corgi/chadian

	var/resting_state = 0

/// AI controller that adds chad ian emotes
/datum/ai_controller/basic_controller/dog/corgi/chadian

/mob/living/basic/pet/dog/corgi/ian/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(resting_state)
		manual_emote(pick("gets up and barks.", "walks around.", "stops resting."))
		set_rest_state(RESTING_STATE_NONE)

/mob/living/basic/pet/dog/corgi/ian/proc/set_rest_state(state)
	resting_state = state
	update_icons()

/mob/living/basic/pet/dog/corgi/ian/update_icons()
	. = ..()

	// Dead
	if(stat)
		icon_state = "[initial(icon_state)][is_slow ? "_old" : ""][shaved ? "_shaved" : ""]_dead"
		return

	// Wheelchair
	if(is_slow)
		icon_state = "[initial(icon_state)]_old[shaved ? "_shaved" : ""]"
		return

	switch(resting_state)
		if(RESTING_STATE_NONE)
			icon_state = initial(icon_state)
		if(RESTING_STATE_SIT)
			icon_state = "[initial(icon_state)]_sit[shaved ? "_shaved" : ""]"
		if(RESTING_STATE_REST)
			icon_state = "[initial(icon_state)]_rest[shaved ? "_shaved" : ""]"

#undef RESTING_STATE_NONE
#undef RESTING_STATE_SIT
#undef RESTING_STATE_REST
