/datum/job
	// Storyteller flags
	var/story_tags = NONE

	var/story_weight = 0

/datum/job_department
	var/job_story_flags = NONE
	var/job_weight_override = 0

/datum/job_department/proc/add_storyweight(datum/job/job)
	if(job.story_weight < job_weight_override)
		job.story_weight = job_weight_override
	if(job_story_flags)
		job.story_tags = job.story_tags | job_story_flags

/datum/job_department/command
	job_weight_override = STORY_HEAD_JOB_WEIGHT
	job_story_flags = STORY_JOB_IMPORTANT

/datum/job_department/security
	job_weight_override = STORY_SECURITY_JOB_WEIGHT
	job_story_flags = STORY_JOB_IMPORTANT|STORY_JOB_COMBAT|STORY_JOB_SECURITY

/datum/job_department/medical
	job_weight_override = STORY_MEDICAL_JOB_WEIGHT
	job_story_flags = STORY_JOB_IMPORTANT

/datum/job_department/engineering
	job_weight_override = STORY_ENGINEER_JOB_WEIGHT

/datum/job_department/science
	job_weight_override = STORY_UNIMPORTANT_JOB_WEIGHT // Science guys don't important for threat progression

/datum/job_department/service
	job_weight_override = STORY_UNIMPORTANT_JOB_WEIGHT
// Heads

//Most important first
/datum/job/captain
	story_tags = STORY_JOB_ANTAG_MAGNET|STORY_JOB_IMPORTANT|STORY_JOB_HEAVYWEIGHT
	story_weight = STORY_HEAD_JOB_WEIGHT * 2

/datum/job/head_of_security
	story_tags = STORY_JOB_ANTAG_MAGNET|STORY_JOB_IMPORTANT|STORY_JOB_HEAVYWEIGHT
	story_weight = STORY_HEAD_JOB_WEIGHT * 2

/datum/job/chief_medical_officer
	story_tags = STORY_JOB_IMPORTANT
	story_weight = STORY_HEAD_JOB_WEIGHT

