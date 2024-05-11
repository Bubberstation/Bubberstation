/datum/round_event
	// A blacklist of maps. Use the full name that appears in map config, under map_name.
	var/list/map_blacklist

/datum/round_event_control/alien_infestation
	map_blacklist = list(
		"Ice Box Station",
		"Blueshift",
		"Void Raptor"
	)

/datum/round_event_control/blob
	map_blacklist = list(
		"Ice Box Station",
		"Blueshift",
		"Void Raptor"
	)

/datum/round_event_control/spider_infestation
	map_blacklist = list(
		"Ice Box Station",
		"Blueshift",
		"Void Raptor"
	)

/datum/round_event_control/blob/can_spawn_event(players, allow_magic = FALSE)

	if(SSmapping.config && SSmapping.config.map_name && (SSmapping.config.map_name in map_blacklist))
		return FALSE

	. = ..()
