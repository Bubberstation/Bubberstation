/obj/item/ectoplasm/revenant/attack_self(mob/user)
	var/mob/living/carbon/carbon = user || usr
	if(carbon.can_block_magic(MAGIC_RESISTANCE_HOLY) || carbon.reagents.has_reagent(/datum/reagent/water/holywater, needs_metabolizing = FALSE))	 // Anyone with Holy Properties can kill the revenant for good.
		. = ..()
	else
		return

/obj/item/ectoplasm/revenant/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	return FALSE
