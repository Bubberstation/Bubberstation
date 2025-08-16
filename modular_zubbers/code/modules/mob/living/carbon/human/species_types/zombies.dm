/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
	. = ..()

/obj/item/bodypart/head/zombie //Override of /tg/ default (code\modules\surgery\bodyparts\species_parts\misc_bodyparts.dm), includes EYECOLOR, HAIR and FACIAL HAIR.
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_EYESPRITES|HEAD_DEBRAIN|HEAD_EYECOLOR

/obj/item/bodypart/head/zombie/New(loc, ...)
	head_flags |= (HEAD_HAIR|HEAD_FACIAL_HAIR)
	. = ..()

/datum/species/zombie/get_species_description()
	return list("A rotting zombie! They descend upon Space Station Thirteen Every year to spook the crew! \"Sincerely, the Zombies!\"",)

/datum/species/zombie/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
		"horns" = list("None", FALSE),
		"spines" = list("None", FALSE),
		"frills" = list("None", FALSE),
	)
