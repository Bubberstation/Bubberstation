/datum/language_holder/felinid/initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nekomimetic = list(LANGUAGE_ATOM)
	)

/datum/language_holder/golem/bone/initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

/datum/language_holder/skeleton/initialize()
	. = ..()
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/piratespeak = list(LANGUAGE_ATOM)
	)

