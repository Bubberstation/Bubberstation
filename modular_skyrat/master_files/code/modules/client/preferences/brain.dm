/datum/preference/choiced/brain_type
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_key = "brain_type"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_NAMES // Apply after species, cause that's super important.

/datum/preference/choiced/brain_type/init_possible_values()
	return list(ORGAN_PREF_POSI_BRAIN, ORGAN_PREF_MMI_BRAIN, ORGAN_PREF_CIRCUIT_BRAIN)

/datum/preference/choiced/brain_type/create_default_value()
	return ORGAN_PREF_POSI_BRAIN

/datum/preference/choiced/brain_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!issynthetic(target))
		return

	var/obj/item/organ/brain/new_brain = target.prefs_get_brain_to_use(value)
	var/obj/item/organ/brain/old_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!new_brain || !old_brain || new_brain == old_brain.type)
		return

	var/datum/mind/keep_me_safe = target.mind

	new_brain = new new_brain()

	new_brain.modular_persistence = old_brain.modular_persistence
	new_brain.modular_persistence?.owner = new_brain
	old_brain.modular_persistence = null

	// pull the old brain ourselves with NO_ID_TRANSFER instead of letting DELETE_IF_REPLACED do it. otherwise the brain
	// hands the occupant off to its brainmob on the way out and we immediately delete the brainmob underneath them
	old_brain.Remove(target, special = TRUE, movement_flags = NO_ID_TRANSFER)
	qdel(old_brain)

	new_brain.Insert(target)

	// Prefs can be applied to mindless mobs, let's not try to move the non-existent mind back in!
	if(!keep_me_safe)
		return

	keep_me_safe.transfer_to(target, TRUE)
