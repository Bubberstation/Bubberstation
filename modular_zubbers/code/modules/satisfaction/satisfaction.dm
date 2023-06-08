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
	var/message_string = "Current Round Survey Results : \n"
	var/list/results = list()
	for(var/i in GLOB.needs_chaos)
		results["more chaos"]++
	if(results["more chaos"])
		message_string += "[results["more chaos"]] have voted for chaos. \n"
	for(var/i in GLOB.needs_less_chaos)
		results["less chaos"]++
	if(results["less chaos"])
		message_string += "[results["less chaos"]] have voted for calm. \n"
	for(var/i in GLOB.needs_antags)
		results["needs antags"]++
	if(results["needs antags"])
		message_string += "[results["needs antags"]] have voted for another antag to be added. \n"
	for(var/i in GLOB.needs_less_antags)
		results["less antags"]++
	if(results["less antags"])
		message_string += "[results["less antags"]] have voted for antags to calm down. \n"
	for(var/i in GLOB.needs_emergency)
		results["needs emergency"]++
	if(results["needs emergency"])
		message_string += "[results["needs emergency"]] have voted for an emegency to occur. \n"
	for(var/i in GLOB.needs_less_emergency)
		results["less emergency"]++
	if(results["less emergency"])
		message_string += "[results["less emergency"]] have voted for the current situation to be resolved. \n"

	for(var/i in GLOB.player_list)
		to_chat(i, "The current survey period has expired, please let your voice be heard and vote in the survey tab again!")

	message_admins(message_string)




/mob/verb/need_chaos()
	set name = "Needs More Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_chaos |= usr
	GLOB.needs_less_chaos -= usr
	usr << "Thanks for your feedback!"

/mob/verb/need_less_chaos()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_chaos |= usr
	GLOB.needs_chaos -= usr
	usr << "Thanks for your feedback!"

/mob/verb/need_antags()
	set name = "Needs More Antags"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_antags |= usr
	GLOB.needs_less_antags -= usr
	usr << "Thanks for your feedback!"

/mob/verb/need_less_antags()
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_antags |= usr
	GLOB.needs_antags -= usr
	usr << "Thanks for your feedback!"

/mob/verb/need_emergency()
	set name = "Needs More Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_emergency |= usr
	GLOB.needs_less_emergency -= usr
	usr << "Thanks for your feedback!"

/mob/verb/need_less_emergency()
	set name = "Needs Less Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_emergency |= usr
	GLOB.needs_emergency -= usr
	usr << "Thanks for your feedback!"
