/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		stack_trace("FreeRole called to free job slot with no rank specified")
		return
	var/datum/job/job = get_job(rank)
	if(!job)
		stack_trace("FreeRole could not map rank [rank] to a job slot")
		return FALSE
	log_econ("Modifying job slots of [job.title]. Existing slots: [job.current_positions]/[job.total_positions] New slots: [max(0, job.current_positions - 1)]/[job.total_positions]")
	job.current_positions = max(0, job.current_positions - 1)

/// Used for clocking back in, re-claiming the previously freed role. Returns false if no slot is available.
/datum/controller/subsystem/job/proc/OccupyRole(rank)
	if(!rank)
		stack_trace("OccupyRole called to free job slot with no rank specified")
		return FALSE
	var/datum/job/job = get_job(rank)
	if(!job)
		stack_trace("FreeRole could not map rank [rank] to a job slot")
		return FALSE
	if(job.current_positions >= job.total_positions)
		log_econ("Modifying job slots of [job.title] failed due to no job slot being available. Current slots: [job.current_positions]/[job.total_positions]")
		return FALSE
	log_econ("Modifying job slots of [job.title]. Existing slots: [job.current_positions]/[job.total_positions] New slots: [job.current_positions + 1]/[job.total_positions]")
	job.current_positions = job.current_positions + 1
	return TRUE
