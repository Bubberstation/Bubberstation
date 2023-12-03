/datum/language_holder/felinid/Initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)

/datum/language_holder/golem/bone/Initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

/datum/language_holder/skeleton/Initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

