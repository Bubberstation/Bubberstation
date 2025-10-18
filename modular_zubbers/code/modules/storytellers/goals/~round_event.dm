/datum/round_event_control/storyteller_control
	name = "storyteller contoled event"

/datum/round_event_control/storyteller_control/valid_for_map()
	return TRUE

/datum/round_event_control/storyteller_control/can_spawn_event(players_amt, allow_magic)
	SHOULD_CALL_PARENT(FALSE)
	return TRUE

/datum/round_event
	//Should event be avaible for random selection? by default? FALSE - It's mean only storyteller can handle with it.
	var/allow_random = TRUE
	// Is this event being run by the storyteller system?
	var/storyteller = FALSE

// Overrading control of the event to the storyteller system
/datum/round_event/proc/__setup_for_storyteller(threat_points, ...)
	SHOULD_CALL_PARENT(TRUE)
	storyteller = TRUE
	SSevents.running -= src
	SSstorytellers.register_active_event(src)

/datum/round_event/proc/__announce_for_storyteller()
	announce()


/datum/round_event/proc/__start_for_storyteller()
	start()



/datum/round_event/proc/__process_for_storyteller(seconds_per_tick)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!processing)
		return

	if(activeFor == start_when)
		processing = FALSE
		__start_for_storyteller()
		processing = TRUE

	if(activeFor == announce_when && prob(announce_chance))
		processing = FALSE
		__announce_for_storyteller()
		processing = TRUE

	if(start_when < activeFor && activeFor < end_when)
		processing = FALSE
		__storyteller_tick(seconds_per_tick)
		processing = TRUE

	if(activeFor == end_when)
		processing = FALSE
		__end_for_storyteller()
		processing = TRUE

	// Everything is done, let's clean up.
	if(activeFor >= end_when && activeFor >= announce_when && activeFor >= start_when)
		processing = FALSE
		__kill_for_storyteller()

	activeFor++



/datum/round_event/proc/__end_for_storyteller()
	end()



/datum/round_event/proc/__kill_for_storyteller()
	SSstorytellers.unregister_active_event(src)
	kill()


/datum/round_event/proc/__storyteller_tick(seconds_per_tick)
	tick()
