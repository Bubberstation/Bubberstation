/datum/heretic_knowledge/rust_sower/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/needed = 30

	for(var/obj/item/reagent_containers/glass in atoms)
		if(!glass.reagents)
			continue

		var/amount = glass.reagents.get_reagent_amount(/datum/reagent/fuel)
		if(amount <= 0)
			continue

		var/take = min(amount, needed)
		glass.reagents.remove_reagent(/datum/reagent/fuel, take)
		needed -= take
		selected_atoms |= glass

		if(needed <= 0)
			return TRUE

	loc.balloon_alert(user, "ritual failed: missing welding fuel (30u)!")
	return FALSE
