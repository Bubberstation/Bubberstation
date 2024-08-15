/obj/item/organ/internal/tongue/arachnid
	name = "inner mandible"
	desc = "A set of soft, spoon-esque mandibles closer to the mouth opening, that allow for basic speech, and the ability to speak Rachnidian."
	say_mod = "chitters"
	liked_foodtypes = MEAT | RAW
	disliked_foodtypes = FRUIT | GROSS
	toxic_foodtypes = VEGETABLES | DAIRY

/obj/item/organ/internal/tongue/arachnid/get_possible_languages() //why is that a proc tho
	return list(
		/datum/language/common,
		/datum/language/machine,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/buzzwords,
	)
