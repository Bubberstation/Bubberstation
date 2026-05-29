#define BASE_BURN_PER_SECOND 0.5

/datum/reagent/silver/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	if (get_lycanthropy_intensity(affected_mob) == 0)
		return

	to_chat(affected_mob, span_userdanger("THE SILVER STEEL OF LUNA IS WITHIN YOUR VERY VEINS! YOUR FLESH BURNS AND BOILS!"))
	affected_mob.emote("scream")

/datum/reagent/silver/on_mob_end_metabolize(mob/living/affected_mob, metabolization_ratio)
	. = ..()

	if (get_lycanthropy_intensity(affected_mob) == 0)
		return

	to_chat(affected_mob, span_bolddanger("You feel comfort return to you as the last of the blessed lunar steel is filtered from your blood."))

/datum/reagent/silver/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	var/intensity = get_lycanthropy_intensity(affected_mob)
	if (intensity == 0)
		return

	// we are a lycan and we have silver in our blood ohhhh noooo broooooooo

	var/damage_amt = BASE_BURN_PER_SECOND * intensity * seconds_per_tick
	affected_mob.apply_damage(
		damage_amt,
		BURN,
		wound_bonus = CANT_WOUND // TODO - maybe have a small chance to cause a burn wound?
	)

	if (SPT_PROB(5, seconds_per_tick))
		to_chat(affected_mob, span_warning("The silver in your veins burns your lycanthropic flesh...!"))
		affected_mob.emote("scream")

/datum/reagent/silver/proc/get_lycanthropy_intensity(mob/living/carbon/affected_mob)
	if (!ishuman(affected_mob))
		return 0

	if (islycan(affected_mob))
		return 3
	else if (iscursekin(affected_mob))
		return 1

	return 0

#undef BASE_BURN_PER_SECOND
