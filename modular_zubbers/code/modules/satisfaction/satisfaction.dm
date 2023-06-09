GLOBAL_LIST_EMPTY(needs_chaos)
GLOBAL_LIST_EMPTY(needs_less_chaos)
GLOBAL_LIST_EMPTY(needs_antags)
GLOBAL_LIST_EMPTY(needs_less_antags)
GLOBAL_LIST_EMPTY(needs_emergency)
GLOBAL_LIST_EMPTY(needs_less_emergency)

SUBSYSTEM_DEF(round_survey)
	name = "Round Survey"
	wait = 10 MINUTES
	flags = SS_BACKGROUND

/datum/controller/subsystem/round_survey/fire()
	var/message_string = "Current Round Survey Results : \n"
	var/list/results = list()

	results["more chaos"] = length(GLOB.needs_chaos)
	if(results["more chaos"])
		message_string += "[results["more chaos"]] have voted for chaos. \n"

	results["less chaos"] = length(GLOB.needs_less_chaos)
	if(results["less chaos"])
		message_string += "[results["less chaos"]] have voted for calm. \n"

	results["needs antags"] = length(GLOB.needs_antags)
	if(results["needs antags"])
		message_string += "[results["needs antags"]] have voted for another antag to be added. \n"


	results["less antags"] = length(GLOB.needs_less_antags)
	if(results["less antags"])
		message_string += "[results["less antags"]] have voted for antags to calm down. \n"


	results["needs emergency"] = length(GLOB.needs_emergency)
	if(results["needs emergency"])
		message_string += "[results["needs emergency"]] have voted for an emegency to occur. \n"

	results["less emergency"] = length(GLOB.needs_less_emergency)
	if(results["less emergency"])
		message_string += "[results["less emergency"]] have voted for the current situation to be resolved. \n"

	for(var/i in GLOB.player_list)
		to_chat(i, "The current survey period has expired, please let your voice be heard and vote in the survey tab again!")

	message_admins(message_string)
	reset()

/datum/controller/subsystem/round_survey/proc/reset()
	QDEL_LIST(GLOB.needs_chaos)
	QDEL_LIST(GLOB.needs_less_chaos)
	QDEL_LIST(GLOB.needs_antags)
	QDEL_LIST(GLOB.needs_less_antags)
	QDEL_LIST(GLOB.needs_emergency)
	QDEL_LIST(GLOB.needs_less_emergency)






/mob/verb/need_chaos()
	set name = "Needs More Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_chaos |= usr
	GLOB.needs_less_chaos -= usr
	to_chat(src, "Thanks for your feedback!")

/mob/verb/need_less_chaos()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_chaos |= usr
	GLOB.needs_chaos -= usr
	to_chat(src, "Thanks for your feedback!")

/mob/verb/need_antags()
	set name = "Needs More Antags"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_antags |= usr
	GLOB.needs_less_antags -= usr
	to_chat(src, "Thanks for your feedback!")

/mob/verb/need_less_antags()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_antags |= usr
	GLOB.needs_antags -= usr
	to_chat(src, "Thanks for your feedback!")

/mob/verb/need_emergency()
	set name = "Needs More Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_emergency |= usr
	GLOB.needs_less_emergency -= usr
	to_chat(src, "Thanks for your feedback!")

/mob/verb/need_less_emergency()
	set name = "Needs Less Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_emergency |= usr
	GLOB.needs_emergency -= usr
	to_chat(src, "Thanks for your feedback!")
