/datum/sprite_accessory/spines
	key = "spines"
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_LIZARD, SPECIES_UNATHI, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	organ_type = /obj/item/organ/spines

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer)
	if(wearer.covered_slots & HIDESPINE)
		return TRUE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	return FALSE

/datum/sprite_accessory/tail_spines
	key = "tailspines"
	default_color = DEFAULT_SECONDARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)

/datum/sprite_accessory/tail_spines/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE

/datum/sprite_accessory/tail_spines/is_hidden(mob/living/carbon/human/wearer)
	var/list/used_in_turf = list("tail")
	if(wearer.owned_turf?.name in used_in_turf)
	// Emote exception
		return TRUE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	if("spines" in wearer.try_hide_mutant_parts)
		return TRUE
	if("tail" in wearer.try_hide_mutant_parts)
		return TRUE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
		// Hide accessory if flagged to do so
		else if(wearer.covered_slots & HIDETAIL)
			return TRUE

	return FALSE
