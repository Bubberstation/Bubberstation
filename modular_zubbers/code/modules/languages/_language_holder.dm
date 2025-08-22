/datum/language_holder/golem/bone/New()
	. = ..()
	understood_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

/datum/language_holder/panslavic
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/spinwarder = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/spinwarder = list(LANGUAGE_ATOM),
	)
	selected_language = /datum/language/spinwarder

/datum/language_holder/panslavic_exclusive
	understood_languages = list(
		/datum/language/spinwarder = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/spinwarder = list(LANGUAGE_ATOM),
	)
	selected_language = /datum/language/spinwarder
