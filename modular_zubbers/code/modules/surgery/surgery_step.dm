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

