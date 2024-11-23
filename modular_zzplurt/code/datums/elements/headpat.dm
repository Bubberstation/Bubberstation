/datum/element/pet_bonus/headpat/on_attack_hand(mob/living/pet, mob/living/petter, list/modifiers)
	if(!(check_zone(petter.zone_selected) == BODY_ZONE_HEAD) || petter == pet)
		return
	. = ..()
