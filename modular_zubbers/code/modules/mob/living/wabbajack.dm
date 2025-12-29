GLOBAL_LIST_INIT(valid_wabbajack_types,generate_valid_wabbajack_types())

/datum/action/cooldown/spell/shapeshift/polymorph_hugbox
	keep_name = TRUE
	cooldown_time = 5 MINUTES
	revert_on_death = TRUE
	die_with_shapeshifted_form = TRUE

/proc/generate_valid_wabbajack_types()

	. = list()

	for(var/mob/living/simple_animal/found_animal in typesof(/mob/living/simple_animal) as anything)
		if(!initial(found_animal.gold_core_spawnable))
			continue
		if(initial(found_animal.del_on_death))
			continue
		. += found_animal

	for(var/mob/living/basic/found_basic in typesof(/mob/living/basic) as anything)
		if(!initial(found_basic.gold_core_spawnable))
			continue
		if(initial(found_basic.basic_mob_flags) & DEL_ON_DEATH)
			continue
		. += found_basic

/mob/living/wabbajack(what_to_randomize, change_flags = WABBAJACK)

	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE) || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(SEND_SIGNAL(src, COMSIG_LIVING_PRE_WABBAJACKED, what_to_randomize) & STOP_WABBAJACK)
		return

	var/datum/action/cooldown/spell/shapeshift/shapeshift_spell = locate() in src.actions
	if(!shapeshift_spell) //If you already have some form of shapeshift, it will force you to transform.

		// Valid polymorph types unlock the Lepton.
		//Copied from original wabbajack proc.
		if((change_flags & (WABBAJACK|MIRROR_MAGIC|MIRROR_PRIDE|RACE_SWAP)) && (SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] != TRUE))
			to_chat(src, span_revennotice("You have the strangest feeling, for a moment. A fragile, dizzying memory wanders into your mind.. all you can make out is-"))
			to_chat(src, span_hypnophrase("You sleep so it may wake. You wake so it may sleep. It wakes. Do not sleep."))
			SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] = TRUE

		shapeshift_spell = new /datum/action/cooldown/spell/shapeshift/polymorph_hugbox(src)
		shapeshift_spell.shapeshift_type = pick(GLOB.valid_wabbajack_types)
		shapeshift_spell.possible_shapes = list(shapeshift_spell.shapeshift_type)
		shapeshift_spell.Grant(src)

	shapeshift_spell.next_use_time = 0
	shapeshift_spell.Trigger()
