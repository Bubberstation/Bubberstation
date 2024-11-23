/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/GiveTarget(new_target)
	var/targets_the_same = (new_target == target)
	. = ..()

	// Escape clause from original
	if(!(. && target && !targets_the_same))
		return

	// Unique dialog for Cursed Blood
	if(HAS_TRAIT(target, TRAIT_CURSED_BLOOD))
		say(pick("Hunter, you must accept your death, be freed from the night.","The night, and the dream, were long...","Beasts all over the shop... You'll be one of them, sooner or later...","The night blocks all sight..."))

