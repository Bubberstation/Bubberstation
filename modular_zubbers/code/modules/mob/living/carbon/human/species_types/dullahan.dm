/datum/species/dullahan
	outfit_important_for_life = /datum/outfit/dullahan

/datum/species/dullahan/on_species_gain(mob/living/carbon/human/human, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(human, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand_primary))
	RegisterSignal(human, COMSIG_ATOM_ATTACK_HAND_SECONDARY, PROC_REF(on_attack_hand_secondary))

/datum/species/dullahan/on_species_loss(mob/living/carbon/human/human)
	UnregisterSignal(human, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(human, COMSIG_ATOM_ATTACK_HAND_SECONDARY)
	return ..()

/// Handle left-click on the dullahan to attach/detach head
/datum/species/dullahan/proc/on_attack_hand_primary(mob/living/carbon/human/attacker, list/modifiers)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/dullahan = attacker

	// Only allow self-interaction
	if(attacker != dullahan)
		return

	var/obj/item/bodypart/head/body_head = dullahan.get_bodypart(BODY_ZONE_HEAD)
	if(!istype(body_head) && my_head && istype(my_head.loc, /obj/item/bodypart/head))
		attach_head(dullahan)
		return COMPONENT_CANCEL_ATTACK_CHAIN
	else if(istype(body_head))
		remove_head(dullahan)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Handle right-click on the dullahan to remove head
/datum/species/dullahan/proc/on_attack_hand_secondary(mob/living/carbon/human/attacker, list/modifiers)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/dullahan = attacker

	// Only allow self-interaction
	if(attacker != dullahan)
		return

	var/obj/item/bodypart/head/body_head = dullahan.get_bodypart(BODY_ZONE_HEAD)
	if(istype(body_head))
		remove_head(dullahan)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/species/dullahan/get_species_description()
	return list("An angry spirit, hanging onto the land of the living for \
		unfinished business. Or that's what the books say. They're quite nice \
		when you get to know them.",)
