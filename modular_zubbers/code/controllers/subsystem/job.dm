/// Returns a list of minds of staff in a particular job
/datum/controller/subsystem/job/proc/get_job_staff_records(job_trim)
	if(isnull(job_trim))
		CRASH("get_job_staff_records called without a job argument")

	. = list()
	for(var/datum/record/locked/target in GLOB.manifest.locked)
		if(target.trim == job_trim)
			. += target
