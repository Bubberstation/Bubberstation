/datum/storyteller/house
	name = "The House (Unpredictable Intensity)"
	desc = "The House gives permission for admins to drive the adminbus straight into the station. \
			All weights set to one at Medium - Low intensity."
	welcome_text = "The House always wins."
	track_data = /datum/storyteller_data/tracks/fragile
	votable = TRUE

	population_min = 50
	storyteller_type = STORYTELLER_TYPE_INTENSE

// All the weights are the same to the house
/datum/storyteller/house/calculate_weights(track)
	for(var/datum/round_event_control/event as anything in SSgamemode.event_pools[track])
		if(event.weight)
			event.calculated_weight = 1
