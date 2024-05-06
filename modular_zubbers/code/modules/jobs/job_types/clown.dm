/datum/job/clown/New()
	job_flags = job_flags & (~JOB_CANNOT_OPEN_SLOTS)
	return ..()
