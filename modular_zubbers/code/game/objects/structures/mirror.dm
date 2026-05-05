/obj/structure/mirror/magic/on_species_change(mob/living/carbon/human/race_changer, datum/species/newrace)
	. = ..()
	if(SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] != TRUE)
		SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_WABBAJACK] = TRUE

