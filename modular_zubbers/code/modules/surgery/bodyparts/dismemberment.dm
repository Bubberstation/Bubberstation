/obj/item/bodypart/head
	can_dismember = TRUE

/obj/item/bodypart/head/try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)

	if(!can_dismember(src)) //No point in running the below if we can't dismember in the first place.
		return FALSE

	if (!owner.cause_wound_of_type_and_severity(WOUND_BLUNT, src, WOUND_SEVERITY_CRITICAL, wound_source = "near dismemberment"))
	    return FALSE //But in case we can't add it for some reason, just do the fallback code!

	return ..()
