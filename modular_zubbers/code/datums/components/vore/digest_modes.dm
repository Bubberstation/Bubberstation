GLOBAL_LIST_INIT(digest_modes, init_digest_modes())

/proc/init_digest_modes()
	var/list/digest_modes = list()
	for(var/datum/digest_mode/digest_mode as anything in subtypesof(/datum/digest_mode))
		var/datum/digest_mode/DM = new digest_mode()
		digest_modes[DM.name] = DM
	return digest_modes

/datum/digest_mode
	var/name = ""
	var/gurgle_noises = FALSE

/datum/digest_mode/proc/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	if(gurgle_noises)
		vore_belly.try_play_gurgle_sound()

/datum/digest_mode/safe
	name = DIGEST_MODE_SAFE
	gurgle_noises = FALSE

/datum/digest_mode/digest
	name = DIGEST_MODE_DIGEST
	gurgle_noises = TRUE

/mob/living/proc/vore_can_negatively_affect()
	#if REQUIRES_PLAYER
	// No player, no deal
	return FALSE
	#else
	if(mind)
		// they were at some point a player, we don't digest them until they get back
		return FALSE
	// Animal, melt em
	return TRUE
	#endif

/mob/living/proc/vore_can_digest()
	if(client)
		var/datum/vore_preferences/vore_prefs = client.get_vore_prefs()
		return vore_prefs?.read_preference(/datum/vore_pref/toggle/digestion)

	return vore_can_negatively_affect()

/mob/living/proc/vore_can_qdel()
	if(client)
		var/datum/vore_preferences/vore_prefs = client.get_vore_prefs()
		return vore_prefs?.read_preference(/datum/vore_pref/toggle/digestion_qdel)

	return vore_can_negatively_affect()

/obj/machinery/cryopod/quiet/vore
	name = "vore cryopod"

/obj/machinery/cryopod/quiet/vore/process()
	return

/obj/machinery/cryopod/quiet/vore/find_control_computer(urgent)
	return

GLOBAL_DATUM_INIT(vore_cryopod, /obj/machinery/cryopod/quiet/vore, new /obj/machinery/cryopod/quiet/vore(null))

// This is hilariously cursed
/proc/remove_player_from_round_safely(mob/living/L)
	// Immediately kick them out of their body so they don't get ghosted in nullspace
	L.ghostize(FALSE)

	// Have to do this before we let the cryopod have them, or it'll throw all their items into nullspace without qdeling them
	for(var/obj/item/item_content as anything in L)
		if(!istype(item_content) || HAS_TRAIT(item_content, TRAIT_NODROP))
			continue
		if(issilicon(L) && istype(item_content, /obj/item/mmi))
			continue
		qdel(item_content)

	GLOB.vore_cryopod.close_machine(L)
	L = null // make sure we're not keeping a ref
	GLOB.vore_cryopod.despawn_occupant()

/obj/vore_belly/proc/digestion_death(mob/living/L)
	if(!L.vore_can_qdel())
		return FALSE
	var/mob/living/living_parent = owner.parent

	if(fancy_sounds)
		play_vore_sound_preypred("vore_sounds_death_fancy_prey", "vore_sounds_death_fancy", pref = /datum/vore_pref/toggle/digestion_noises)
	else
		play_vore_sound_preypred("vore_sounds_death_classic", "vore_sounds_death_classic", pref = /datum/vore_pref/toggle/digestion_noises)
	living_parent.adjust_nutrition(NUTRITION_PER_KILL)

	to_chat(living_parent, span_notice(get_digest_messages_pred(L)))
	to_chat(L, span_notice(get_digest_messages_prey(L)))

	living_parent.log_message("digested and qdel'd [key_name(L)].", LOG_ATTACK)
	L.log_message("was digested and qdel'd by [key_name(living_parent)].", LOG_VICTIM)

	remove_player_from_round_safely(L)
	return TRUE

/datum/digest_mode/digest/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	var/mob/living/living_parent = vore_belly.owner.parent

	for(var/mob/living/L in vore_belly)
		if(!L.vore_can_digest())
			continue
		if(L.stat == DEAD)
			if(L.vore_can_qdel())
				vore_belly.digestion_death(L)
			continue
		if(vore_belly.brute_damage > 0)
			L.adjustBruteLoss(vore_belly.brute_damage * seconds_per_tick)
			living_parent.adjust_nutrition(NUTRITION_PER_DAMAGE * vore_belly.brute_damage * seconds_per_tick)
		if(vore_belly.burn_damage > 0)
			L.adjustFireLoss(vore_belly.burn_damage * seconds_per_tick)
			living_parent.adjust_nutrition(NUTRITION_PER_DAMAGE * vore_belly.burn_damage * seconds_per_tick)

/datum/digest_mode/absorb
	name = DIGEST_MODE_ABSORB
	gurgle_noises = TRUE

/mob/living/proc/vore_can_absorb()
	if(client)
		var/datum/vore_preferences/vore_prefs = client.get_vore_prefs()
		return vore_prefs?.read_preference(/datum/vore_pref/toggle/absorb)

	// Arguably, absorption is completely reversable and therefore harmless
	// and this could just return TRUE
	// But in case there's a player that logs out and really really doesn't like absorption...
	return vore_can_negatively_affect()

/obj/vore_belly/proc/absorb(mob/living/L)
	if(!L.vore_can_absorb())
		return FALSE
	// Already absorbed
	if(HAS_TRAIT_FROM(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		return FALSE

	var/mob/living/living_parent = owner.parent

	// Add full restraints
	ADD_TRAIT(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE)
	ADD_TRAIT(L, TRAIT_STASIS, TRAIT_SOURCE_VORE)

	to_chat(living_parent, span_notice(get_absorb_messages_owner(L)))
	to_chat(L, span_notice(get_absorb_messages_prey(L)))

	return TRUE

/datum/digest_mode/absorb/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	var/mob/living/living_parent = vore_belly.owner.parent

	for(var/mob/living/L in vore_belly)
		if(!L.vore_can_absorb())
			continue
		if(HAS_TRAIT_FROM(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
			continue
		if(L.nutrition < ABSORB_NUTRITION_BARRIER)
			vore_belly.absorb(L)
			continue
		// Times 2 because we assume a baseline of 2 "damage" in absorb mode
		var/nutrition_transfer = NUTRITION_PER_DAMAGE * 2 * seconds_per_tick
		L.adjust_nutrition(-nutrition_transfer)
		living_parent.adjust_nutrition(nutrition_transfer)

/datum/digest_mode/unabsorb
	name = DIGEST_MODE_UNABSORB
	gurgle_noises = TRUE

/obj/vore_belly/proc/unabsorb(mob/living/L)
	// Not absorbed
	if(!HAS_TRAIT_FROM(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		return FALSE

	var/mob/living/living_parent = owner.parent

	// Remove full restraints
	REMOVE_TRAIT(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE)
	REMOVE_TRAIT(L, TRAIT_STASIS, TRAIT_SOURCE_VORE)

	to_chat(living_parent, span_notice(get_unabsorb_messages_owner(L)))
	to_chat(L, span_notice(get_unabsorb_messages_prey(L)))

	// Unabsorbs kick them back out
	var/datum/component/absorb_control/AC = living_parent.GetComponent(/datum/component/absorb_control)
	if(AC && AC.controller == L)
		AC.revert()

	return TRUE

/datum/digest_mode/unabsorb/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	var/mob/living/living_parent = vore_belly.owner.parent

	for(var/mob/living/L in vore_belly)
		if(!HAS_TRAIT_FROM(L, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
			continue
		// Parent can only reform if they have ABSORB_NUTRITION_BARRIER worth of nutrition
		// Note that this nutrition is deliberately lost and not given back to the prey
		if(living_parent.nutrition > ABSORB_NUTRITION_BARRIER)
			living_parent.adjust_nutrition(-ABSORB_NUTRITION_BARRIER)
			vore_belly.unabsorb(L)
