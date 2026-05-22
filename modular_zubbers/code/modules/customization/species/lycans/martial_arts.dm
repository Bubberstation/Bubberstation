/datum/martial_art/can_use(mob/living/martial_artist)
	. = ..()

	if (!.)
		return FALSE

	if (HAS_TRAIT(martial_artist, TRAIT_MARTIAL_ARTS_UNUSABLE))
		return FALSE
