/datum/round_event
	//Should event be avaible for random selection? by default? FALSE - It's mean only storyteller can handle with it.
	var/allow_random = TRUE
	// Is this event being run by the storyteller system?
	var/storyteller_implementation = FALSE

	VAR_PRIVATE/datum/storyteller_inputs/___storyteller_inputs = null

	VAR_PRIVATE/datum/storyteller/___storyteller = null

	VAR_PRIVATE/___additional_arguments = list()

// Overrading control of the event to the storyteller system
/datum/round_event/proc/__setup_for_storyteller(threat_points, ...)
	SHOULD_CALL_PARENT(TRUE)
	if(storyteller_implementation)
		if(islist(___additional_arguments))
			___additional_arguments = args[1]
		else
			___additional_arguments = list(args[1])
		___storyteller_inputs = args[2]
		___storyteller = args[3]
	else
		setup()

/datum/round_event/proc/get_executer()
	PROTECTED_PROC(TRUE)
	RETURN_TYPE(/datum/storyteller)

	return ___storyteller

/datum/round_event/proc/get_inputs()
	PROTECTED_PROC(TRUE)
	RETURN_TYPE(/datum/storyteller_inputs)

	return ___storyteller_inputs

/datum/round_event/proc/get_additional_arguments()
	PROTECTED_PROC(TRUE)
	RETURN_TYPE(/list)

	return ___additional_arguments


/datum/round_event/proc/__announce_for_storyteller()


/datum/round_event/proc/__start_for_storyteller()


/datum/round_event/proc/__process_for_storyteller(seconds_per_tick)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!processing)
		return

	if(activeFor == start_when)
		processing = FALSE
		if(storyteller_implementation)
			__start_for_storyteller()
		else
			start()
		processing = TRUE

	if(activeFor == announce_when && prob(announce_chance))
		processing = FALSE
		if(storyteller_implementation)
			__announce_for_storyteller()
		else
			announce()
		processing = TRUE

	if(start_when < activeFor && activeFor < end_when)
		processing = FALSE
		if(storyteller_implementation)
			__storyteller_tick(seconds_per_tick)
		else
			tick()
		processing = TRUE

	if(activeFor == end_when && end_when >= start_when)
		processing = FALSE
		if(storyteller_implementation)
			__end_for_storyteller()
		else
			end()
		processing = TRUE

	// Everything is done, let's clean up.
	if(activeFor >= end_when && activeFor >= announce_when && activeFor >= start_when)
		processing = FALSE
		if(storyteller_implementation)
			__kill_for_storyteller()
		else
			kill()
		___deregister()
	activeFor++



/datum/round_event/proc/__end_for_storyteller()


/datum/round_event/proc/__kill_for_storyteller()


/datum/round_event/proc/__register()
	if(src in SSevents.running)
		SSevents.running -= src
	SSstorytellers.register_active_event(src)

/datum/round_event/proc/___deregister()
	SSstorytellers.unregister_active_event(src)

/datum/round_event/proc/__storyteller_tick(seconds_per_tick)

