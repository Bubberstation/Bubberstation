/datum/weather/rad_storm
	end_duration = 3 SECONDS
	telegraph_message = span_userdanger("The air begins to grow warm.")
	var/maint_flipped = FALSE

/datum/weather/rad_storm/New(...)
	LAZYOR(protected_areas, list(
		/area/station/terminal,
		/area/lavaland,
		/area/ruin,
		/area/moonstation/underground,
		/area/station/cargo/miningelevators,
		/area/station/cargo/miningfoundry/event_protected,
		/area/loopstation/radshelter,
		/area/ruin/unpowered/primitive_catgirl_den,
	))
	. = ..()

/datum/weather/rad_storm/telegraph()
	. = ..()
	if(!GLOB.emergency_access)
		maint_flipped = TRUE
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(make_maint_all_access), TRUE), 0.5 SECONDS) // timed to match the status display

/datum/weather/rad_storm/end()
	. = ..()
	if(maint_flipped)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 45 SECONDS)

//Radstorm mutation resistance OVERRIDE

/datum/weather/rad_storm/weather_act_mob(mob/living/living)
	if(!prob(mutate_chance))
		return

	if(!ishuman(living) || HAS_TRAIT(living, TRAIT_GODMODE))
		return

	var/mob/living/carbon/human/human = living
	if(!human.can_mutate())
		return

	if(HAS_TRAIT(human, TRAIT_RAD_RESISTANCE))
		return

	if(HAS_TRAIT(human, TRAIT_RADIMMUNE))
		return

	if (SSradiation.wearing_rad_protected_clothing(human))
		return

	human.random_mutate_unique_identity()
	human.random_mutate_unique_features()

	if(prob(50))
		do_mutate(human)

	return ..()

//Radstorm mutation resistance OVERRIDE

/datum/weather/rad_storm/weather_act_mob(mob/living/living)
	if(!prob(mutate_chance))
		return

	if(!ishuman(living) || HAS_TRAIT(living, TRAIT_GODMODE))
		return

	var/mob/living/carbon/human/human = living
	if(!human.can_mutate())
		return

	if(HAS_TRAIT(human, TRAIT_RAD_RESISTANCE))
		return

	if(HAS_TRAIT(human, TRAIT_RADIMMUNE))
		return

	if (SSradiation.wearing_rad_protected_clothing(human))
		return

	human.random_mutate_unique_identity()
	human.random_mutate_unique_features()

	if(prob(50))
		do_mutate(human)

	return ..()
