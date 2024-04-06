/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
	. = ..()

/obj/item/bodypart/head/zombie/New(loc, ...)
	head_flags |= (HEAD_HAIR|HEAD_FACIAL_HAIR)
	. = ..()
