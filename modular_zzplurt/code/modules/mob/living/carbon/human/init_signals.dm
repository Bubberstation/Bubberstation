/mob/living/carbon/human/on_fat(datum/source)
	if(HAS_TRAIT(src, TRAIT_INCUBUS) || HAS_TRAIT(src, TRAIT_SUCCUBUS))
		return //Incubi and succubi don't get fat drawbacks (but can still be seen on examine)
	. = ..()

