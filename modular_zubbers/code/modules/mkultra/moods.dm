/datum/mood_event/enthrall
	mood_change = 5

/datum/mood_event/enthrall/add_effects(message)
	description = "<span class='nicegreen'>[message]</span>\n"

/datum/mood_event/enthrallpraise
	mood_change = 10
	timeout = 1 MINUTES

/datum/mood_event/enthrallpraise/add_effects(message)
	description = "<span class='nicegreen'>[message]</span>\n"

/datum/mood_event/enthrallscold
	mood_change = -10
	timeout = 1 MINUTES

/datum/mood_event/enthrallscold/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"//aaa I'm not kinky enough for this

/datum/mood_event/enthrallmissing1
	mood_change = -5

/datum/mood_event/enthrallmissing1/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"

/datum/mood_event/enthrallmissing2
	mood_change = -10

/datum/mood_event/enthrallmissing2/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"

/datum/mood_event/enthrallmissing3
	mood_change = -15

/datum/mood_event/enthrallmissing3/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"

/datum/mood_event/enthrallmissing4
	mood_change = -25

/datum/mood_event/enthrallmissing4/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"

/datum/mood_event/InLove
	mood_change = 10

/datum/mood_event/InLove/add_effects(message)
	description = "<span class='nicegreen'>[message]</span>\n"

/datum/mood_event/MissingLove
	mood_change = -10

/datum/mood_event/MissingLove/add_effects(message)
	description = "<span class='warning'>[message]</span>\n"

//Putting the movespeed modifier here because I'm lazy <3
/datum/movespeed_modifier/status_effect/mkultra
	multiplicative_slowdown = -2
	blacklisted_movetypes= FLYING|FLOATING
