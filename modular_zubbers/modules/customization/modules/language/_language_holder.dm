/datum/language_holder/felinid/New()
	. = ..()
	understood_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)
	spoken_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)

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

/datum/language_holder/skeleton/New()
	. = ..()
	understood_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages |= list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

