/datum/storyteller/clown
	name = "The Clown"
	desc = "The Clown will try to create the most events and antagonists out of all the storytellers, not caring for their weight. \
	As such, it can be truly chaotic and even end rounds prematurely."
	welcome_text = "honk"

	track_data = /datum/storyteller_data/tracks/clown

	population_min = 50
	antag_divisor = 4
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller_data/tracks/clown
	threshold_mundane = 700
	threshold_moderate = 1600
	threshold_major = 3200
	threshold_crewset = 1000
	threshold_ghostset = 3200

// All the weights are the same to the clown
/datum/storyteller/clown/calculate_weights(track)
	for(var/datum/round_event_control/event as anything in SSgamemode.event_pools[track])
		if(event.weight)
			event.calculated_weight = 1
