/datum/mood_event/food/add_effects(param)
	if(quality > FOOD_QUALITY_GOOD)
		var/effect_strength = quality - FOOD_QUALITY_GOOD
		var/mob/living/carbon/human/O = owner
		if(istype(O))
			O.apply_status_effect(/datum/status_effect/food/quality_healing, effect_strength)


/datum/status_effect/food/quality_healing
	id = "food_quality_healing"
	duration = 5 MINUTES

	/// Used to determine how good our heal is
	var/qheal_strength = 1

/datum/status_effect/food/quality_healing/on_creation(mob/living/new_owner, _qheal_strength)
	qheal_strength = _qheal_strength
	return ..()

/datum/status_effect/food/quality_healing/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/O = owner
	if(istype(O))
		if(ishuman)
			if((O.health/O.maxHealth) > 0.4)
				var/healpwr = ((0.05 + (qheal_strength * 0.3)) * (O.health/O.maxHealth))
				O.heal_bodypart_damage(brute = healpwr, burn = healpwr, required_bodytype = BODYTYPE_ORGANIC)
				for(var/obj/item/organ/internal/stomach/S in O.organs)
					S.apply_organ_damage((S.healing_factor * healpwr))
