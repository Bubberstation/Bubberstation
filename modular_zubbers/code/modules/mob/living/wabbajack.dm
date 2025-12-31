GLOBAL_LIST_INIT(valid_wabbajack_types,generate_valid_wabbajack_types())

/datum/action/cooldown/spell/shapeshift/polymorph_hugbox
	name = "Revert Form"
	desc = "I want to get off Mr. Wizard's wild ride!"
	keep_name = TRUE
	cooldown_time = 5 MINUTES
	revert_on_death = TRUE
	die_with_shapeshifted_form = TRUE
	spell_requirements = NONE
	text_cooldown = TRUE
	cooldown_rounding = 1
	shared_cooldown = NONE

/datum/action/cooldown/spell/shapeshift/polymorph_hugbox/do_unshapeshift(mob/living/caster)
	. = ..()
	if(.)
		src.Remove(caster)

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

/mob/living/wabbajack(what_to_randomize, change_flags = WABBAJACK)

	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE) || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	var/datum/action/cooldown/spell/shapeshift/polymorph_hugbox/shapeshift_spell = locate() in src.actions
	if(!shapeshift_spell)

		//We don't have the spell, so create it.

		//Unless we're wabbajack proof.
		if(SEND_SIGNAL(src, COMSIG_LIVING_PRE_WABBAJACKED, what_to_randomize) & STOP_WABBAJACK)
			return

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

	if(shapeshift_spell)
		shapeshift_spell.Trigger(src,TRIGGER_FORCE_AVAILABLE)

