/area
	/// Is the area free of blood for medical purposes
	var/clean_medical = FALSE

/obj/structure/table/optable
	var/datum/weakref/current_area

/obj/structure/table/optable/Initialize(mapload)
	. = ..()
	current_area = WEAKREF(get_area(src))

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

/obj/structure/table/optable/proc/blood_check()
	var/area/medical_area = current_area?.resolve()
	if(!medical_area)
		return

	for(var/obj/effect/decal/cleanable/blood/bloody_tile in medical_area.contents)
		if(bloody_tile.bloodiness == 0)
			medical_area.clean_medical = FALSE
			return

	medical_area.clean_medical = TRUE
