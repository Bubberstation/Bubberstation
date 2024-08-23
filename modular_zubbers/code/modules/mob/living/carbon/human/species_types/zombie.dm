/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
	. = ..()

/obj/item/bodypart/head/zombie/New(loc, ...)
	head_flags |= (HEAD_HAIR|HEAD_FACIAL_HAIR)
	. = ..()

/datum/species/zombie/get_species_description()
	return list("A rotting zombie! They descend upon Space Station Thirteen Every year to spook the crew! \"Sincerely, the Zombies!\"",)
