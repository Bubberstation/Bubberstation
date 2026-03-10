GLOBAL_LIST_INIT(valid_wabbajack_types,generate_valid_wabbajack_types())

/proc/generate_valid_wabbajack_types()

	. = list()

	for(var/mob/living/simple_animal/found_animal as anything in typesof(/mob/living/simple_animal))
		if(!initial(found_animal.gold_core_spawnable))
			continue
		if(initial(found_animal.del_on_death))
			continue
		. += found_animal

	for(var/mob/living/basic/found_basic as anything in typesof(/mob/living/basic))
		if(!initial(found_basic.gold_core_spawnable))
			continue
		if(initial(found_basic.basic_mob_flags) & DEL_ON_DEATH)
			continue
		. += found_basic