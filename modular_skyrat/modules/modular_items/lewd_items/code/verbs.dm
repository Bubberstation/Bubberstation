GAME_VERB(/mob/living/carbon/human, climax_verb, "Climax", "IC")
	if(!has_status_effect(/datum/status_effect/climax_cooldown))
		if(tgui_alert(usr, "Are you sure you want to cum?", "Climax", list("Yes", "No")) == "Yes")
			if(stat != CONSCIOUS)
				to_chat(usr, span_warning("You can't climax right now..."))
				return
			else
				climax(TRUE)
	else
		to_chat(src, span_warning("You can't cum right now!"))

GAME_VERB(/mob/living, reflexes_verb, "Toggle Reflexes", "IC")
	if(!HAS_TRAIT_FROM(src, TRAIT_QUICKREFLEXES, REF(src)))
		ADD_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
		to_chat(src, span_notice("[get_reflexes_gain_text()]"))
	else
		REMOVE_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
		to_chat(src, span_notice("[get_reflexes_lose_text()]"))

/mob/living/proc/get_reflexes_gain_text()
	return "You don't feel like being touched right now."

/mob/living/proc/get_reflexes_lose_text()
	return "You'll allow yourself to be touched now."

/mob/living/silicon/get_reflexes_gain_text()
	return "Our systems will disallow platonic contact."

/mob/living/silicon/get_reflexes_lose_text()
	return "Our systems will allow platonic contact."

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		UNASSIGN_GAME_VERB(src, /mob/living/carbon/human, climax_verb)
	if(CONFIG_GET(flag/disable_lewd_items))
		UNASSIGN_GAME_VERB(src, /mob/living/carbon/human, safeword)

GAME_VERB_DESC(/mob/living/carbon/human, remove_lewd_items, "Remove Lewd Items", "Removes any and all lewd items from you.", "OOC")
	// literally just another way to safeword
	safeword()

GAME_VERB_DESC(/mob/living/carbon/human, safeword, "OOC Safe Word", "Removes any and all lewd items from you.", "OOC")
	SEND_SIGNAL(src, COMSIG_OOC_ESCAPE)
	log_message("[key_name(src)] used the OOC Safe Word verb.", LOG_ATTACK)
	for(var/obj/item/equipped_item in get_equipped_items())
		if(!(equipped_item.type in GLOB.pref_checked_clothes))
			continue

		log_message("[equipped_item] was removed from [key_name(src)].", LOG_ATTACK)
		dropItemToGround(equipped_item, TRUE)

	// Leashes are treated a smidge different than the rest of the clothing; and need their own handling here.
	var/leash_check = src?.GetComponent(/datum/component/leash/erp)
	if(leash_check)
		qdel(leash_check)

	// Vore Edit
	if(istype(loc, /obj/vore_belly))
		forceMove(get_turf(src))

	return TRUE

GAME_VERB(/mob/living/carbon/human, lick, "Lick", "IC", mob/living/carbon/human/target in get_adjacent_humans())
	if(!istype(target))
		return FALSE

	var/taste = target?.dna?.features["taste"]
	if(!taste)
		to_chat(src, span_warning("[target] doesn't seem to have a taste."))
		return FALSE

	to_chat(src, span_notice("[target] tastes like [taste]."))
	to_chat(target, span_notice("[src] licks you."))

GAME_VERB(/mob/living/carbon/human, smell, "Smell", "IC", mob/living/carbon/human/target in get_adjacent_humans())
	if(!istype(target))
		return FALSE

	var/smell = target?.dna?.features["smell"]
	if(!smell)
		to_chat(src, span_warning("[target] doesn't seem to have a smell."))
		return FALSE

	to_chat(src, span_notice("[target] smells like [smell]."))

/// Returns a list containing all of the humans adjacent to the user.
/mob/living/proc/get_adjacent_humans()
	var/list/nearby_humans = orange(1, src)
	for(var/mob/living/carbon/human/nearby_human as anything in nearby_humans)
		if(ishuman(nearby_human))
			continue

		nearby_humans -= nearby_human

	return nearby_humans

