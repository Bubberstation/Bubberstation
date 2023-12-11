/datum/dynamic_ruleset/roundstart/heretics/New()
	. = ..()
	protected_roles += list(
		JOB_CHAPLAIN, //A chaplain shouldn't be a heretic... just saying
	)
