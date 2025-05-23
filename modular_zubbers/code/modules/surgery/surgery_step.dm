/datum/surgery_step
	/// Information about the result of the last cycle of the surgery step
	var/feedback_value = null

/// Checks if a mob under surgery has sterilizine applied
/mob/living/proc/has_sterilizine()
	if(!length(reagents.reagent_list))
		return FALSE

	for(var/datum/reagent/chem as anything in reagents.reagent_list)
		if(istype(chem, /datum/reagent/space_cleaner/sterilizine))
			return TRUE
		if(istype(chem, /datum/reagent/cryostylane))
			return TRUE

	return FALSE

/datum/surgery_step/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = TRUE)
	SEND_SIGNAL(user, COMSIG_MOB_SURGERY_STEP_SUCCESS, src, target, target_zone, tool, surgery, default_display_results)
	if(default_display_results)
		display_results(
			user,
			target,
			span_notice("You succeed."),
			span_notice("[user] succeeds!"),
			span_notice("[user] finishes."),
		)
	if(ishuman(user))
		var/mob/living/carbon/human/surgeon = user
		if (ishuman(target))
			var/mob/living/carbon/human/human_target = target
			var/obj/item/bodypart/target_bodypart = target.get_bodypart(target_zone)
			var/obj/item/organ/eyes/target_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
			if(target_bodypart)
				if(target_bodypart.bodytype != BODYTYPE_ROBOTIC && !HAS_TRAIT(human_target, TRAIT_NOBLOOD))
					surgeon.add_blood_DNA_to_items(target.get_blood_dna_list(), ITEM_SLOT_GLOVES)
			else if(target_eyes) // snowflake case for eyes
				if(target_eyes.organ_flags != ORGAN_ROBOTIC && !HAS_TRAIT(human_target, TRAIT_NOBLOOD))
					surgeon.add_blood_DNA_to_items(target.get_blood_dna_list(), ITEM_SLOT_GLOVES)
		else
			surgeon.add_blood_DNA_to_items(target.get_blood_dna_list(), ITEM_SLOT_GLOVES)
	else
		user.add_mob_blood(target)
	return TRUE
