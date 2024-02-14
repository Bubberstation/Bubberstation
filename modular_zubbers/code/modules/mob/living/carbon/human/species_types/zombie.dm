/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
	. = ..()
