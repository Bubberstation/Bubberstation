/obj/item/bodypart/head
	can_dismember = TRUE

/obj/item/bodypart/head/try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)

	if(!can_dismember(src)) //No point in running the below if we can't dismember in the first place.
		return FALSE

	if(!src.get_wound_type(/datum/wound/blunt/bone/critical)) //If we don't have this wound...
		var/datum/wound/blunt/bone/critical/wound_to_add = new //Give it to them...
		if(wound_to_add.apply_wound(src,wound_source = "near dismemberment")) //But in case we can't add it for some reason, just do the fallback code!
			return FALSE

	return ..()
