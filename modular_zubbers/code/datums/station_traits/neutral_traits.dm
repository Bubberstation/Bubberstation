/datum/station_trait/triple_ai
	name = "AI Triumvirate"
	trait_type = STATION_TRAIT_NEUTRAL
	show_in_report = TRUE
	weight = 1
	report_message = "Your station has been instated with three Nanotrasen Artificial Intelligence models."

/datum/station_trait/triple_ai/New()
	. = ..()
	RegisterSignal(SSjob, COMSIG_OCCUPATIONS_DIVIDED, PROC_REF(on_occupations_divided))
	if(!GLOB.triple_ai_controller)
		GLOB.triple_ai_controller = new()

/datum/station_trait/triple_ai/revert()
	UnregisterSignal(SSjob, COMSIG_OCCUPATIONS_DIVIDED)
	if(GLOB.triple_ai_controller)
		QDEL_NULL(GLOB.triple_ai_controller)
	return ..()

/datum/station_trait/triple_ai/proc/on_occupations_divided(datum/source, pure, allow_all)
	SIGNAL_HANDLER
	if(!GLOB.triple_ai_controller)
		return

	for(var/datum/job/ai/ai_datum in SSjob.joinable_occupations)
		ai_datum.spawn_positions = 3
		ai_datum.total_positions = 3
	if(!pure)
		for(var/obj/effect/landmark/start/ai/secondary/secondary_ai_spawn in GLOB.start_landmarks_list)
			secondary_ai_spawn.latejoin_active = TRUE
