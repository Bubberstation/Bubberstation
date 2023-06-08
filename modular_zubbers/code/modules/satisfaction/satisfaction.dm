GLOBAL_LIST_EMPTY(needs_chaos)
GLOBAL_LIST_EMPTY(needs_less_chaos)
GLOBAL_LIST_EMPTY(needs_antags)
GLOBAL_LIST_EMPTY(needs_less_antags)
GLOBAL_LIST_EMPTY(needs_emergency)
GLOBAL_LIST_EMPTY(needs_less_emergency)

SUBSYSTEM_DEF(round_survey)
	name = "Round Survey"
	wait = 30 SECONDS
	flags = SS_BACKGROUND

/datum/controller/subsystem/round_survey/fire()

	var/list/results = list()
	for(var/i in GLOB.needs_chaos)
		results["more chaos"]++
	for(var/i in GLOB.needs_less_chaos)
		results["less chaos"]++
	for(var/i in GLOB.needs_antags)
		results["needs antags"]++
	for(var/i in GLOB.needs_less_antags)
		results["less antags"]++
	for(var/i in GLOB.needs_emergency)
		results["needs emergency"]++
	for(var/i in GLOB.needs_less_emergency)
		results["less emergency"]++



	message_admins("Current Round Feedback Tally: More Chaos: [results["more chaos"]], Less Chaos: [results["less chaos"]]\n \
	More Antags: [results["needs antags"]], Less Antags: [results["less antags"]] \n \
	Desires an Emergency: [results["needs emergency"]], Less Emergency: [results["less emergency"]]")




/mob/verb/need_chaos()
	set name = "Needs More Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_chaos |= usr
	GLOB.needs_less_chaos -= usr
//	usr << "Thanks for your feedback!"

/mob/verb/need_less_chaos()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_chaos |= usr
	GLOB.needs_chaos -= usr

/mob/verb/need_antags()
	set name = "Needs More Antags"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_antags |= usr
	GLOB.needs_less_antags -= usr

/mob/verb/need_less_antags()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_antags |= usr
	GLOB.needs_antags -= usr

/mob/verb/need_emergency()
	set name = "Needs More Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_emergency |= usr
	GLOB.needs_less_emergency -= usr
/mob/verb/need_less_emergency()
	set name = "Needs Less Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_emergency |= usr
	GLOB.needs_emergency -= usr
