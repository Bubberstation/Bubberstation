/datum/wound_pregen_data/cranial_fissure/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	return 0

/obj/item/bodypart/head
	can_dismember = TRUE

/obj/item/bodypart/head/try_dismember(wounding_type, wounding_dmg, wound_bonus, exposed_wound_bonus)

	if(!can_dismember(src)) //No point in running the below if we can't dismember in the first place.
		return FALSE

	if(owner.cause_wound_of_type_and_severity(WOUND_BLUNT, src, WOUND_SEVERITY_CRITICAL, wound_source = "near dismemberment"))
		return FALSE //If we can add it, it means we didn't have it and we shouldn't run dismember code.

	return ..()
