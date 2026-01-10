/mob/living/wabbajack(what_to_randomize, change_flags = WABBAJACK)

	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE) || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	//Special handlers for getting wabbajacked, usually while already wabbajacked.
	if(SEND_SIGNAL(src, COMSIG_LIVING_PRE_WABBAJACKED, what_to_randomize) & STOP_WABBAJACK)
		return

	//Remove the existing source of transformation, if we had any to begin with.
	//COMSIG_LIVING_PRE_WABBAJACKED usually does this anyways if you're shape changed, but this is a fallback just in case.
	src.remove_status_effect(/datum/status_effect/shapechange_mob/from_spell)

	//Remove our old spell, if we had any to begin with.
	var/datum/action/cooldown/spell/shapeshift/polymorph_hugbox/shapeshift_spell = locate() in src.actions
	if(shapeshift_spell)
		shapeshift_spell.Remove(src)

	//Create the new spell
	shapeshift_spell = new /datum/action/cooldown/spell/shapeshift/polymorph_hugbox(src)
	shapeshift_spell.shapeshift_type = pick(GLOB.valid_wabbajack_types)
	shapeshift_spell.possible_shapes = list(shapeshift_spell.shapeshift_type)
	shapeshift_spell.Grant(src)

	// Valid polymorph types unlock the Lepton.
	//Copied from original wabbajack proc.
	if((change_flags & (WABBAJACK|MIRROR_MAGIC|MIRROR_PRIDE|RACE_SWAP)) && (SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] != TRUE))
		to_chat(src, span_revennotice("You have the strangest feeling, for a moment. A fragile, dizzying memory wanders into your mind.. all you can make out is-"))
		to_chat(src, span_hypnophrase("You sleep so it may wake. You wake so it may sleep. It wakes. Do not sleep."))
		SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] = TRUE

	shapeshift_spell.Trigger(src,TRIGGER_FORCE_AVAILABLE)
