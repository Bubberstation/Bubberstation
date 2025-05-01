/datum/holiday/april_fools/celebrate()
	. = ..()
	GLOB.maintenance_loot += list(
		/obj/item/skub = maint_holiday_weight
	)

/obj/item/skub/Initialize(mapload)

	. = ..()

	if(check_holidays(APRIL_FOOLS))
		name = "[pick(GLOB.adjectives)] skub"
		override_notes = TRUE
		offensive_notes = pick(strings(REDPILL_FILE, "redpill_questions"))
		force_string = "yes"
		if(!prob(80)) //Atmos optimization.
			// https://www.desmos.com/calculator/tsezwkvo8t
			var/chosen_rng = rand(1,1000) // Basically a 1 in 5000 chance to find a skub that is a lot of damage.
			var/chosen_damage = ((chosen_rng*0.01)+(chosen_rng*0.00139)**16)*0.5
			force = 1 + round(rand(1,chosen_damage),1)
		else
			force = 1
