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
