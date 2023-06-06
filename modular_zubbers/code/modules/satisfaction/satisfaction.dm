GLOBAL_LIST_EMPTY(needs_chaos)
GLOBAL_LIST_EMPTY(needs_less_chaos)
GLOBAL_LIST_EMPTY(needs_antags)
GLOBAL_LIST_EMPTY(needs_less_antags)
GLOBAL_LIST_EMPTY(needs_emergency)
GLOBAL_LIST_EMPTY(needs_less_emergency)

/mob/verb/need_chaos
	set name = "Needs More Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_chaos += usr

/mob/verb/need_less_chaos
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_chaos += usr

/mob/verb/need_antags
	set name = "Needs Antags"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_antags += usr

/mob/verb/need_less_antags
	set name = "Needs Less Chaos"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_antags += usr

/mob/verb/need_emergency
	set name = "Needs Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_emergency += usr

/mob/verb/need_less_emergency
	set name = "Needs Less Emergency"
	set category = "Survey"
	set desc = "Indicate Current Round Mood"
	GLOB.needs_less_emergency += usr
