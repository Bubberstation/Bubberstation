/// Checks if a mob under surgery has sterilizine applied
/datum/surgery_step/proc/has_sterilizine(mob/living/carbon/target)
	if(!length(target.reagents?.reagent_list))
		return FALSE

	for(var/datum/reagent/chem as anything in target.reagents.reagent_list)
		if(istype(chem, /datum/reagent/space_cleaner/sterilizine))
			return TRUE

	return FALSE
