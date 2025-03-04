/datum/mood_event/food/add_effects(param)
	. = ..()
	if(quality >= FOOD_QUALITY_VERYGOOD)
		var/effect_strength = quality - FOOD_QUALITY_VERYGOOD
		var/mob/living/carbon/human/O = owner
		if(istype(O))
			O.apply_status_effect(/datum/status_effect/food/quality_healing, effect_strength)


/datum/status_effect/food/quality_healing
	id = "food_quality_healing"
	status_type = STATUS_EFFECT_REPLACE //The last food you ate should be the one to affect it

	/// Used to determine how good our heal is
	var/qheal_strength = 0
	var/healpwr = 3

/datum/status_effect/food/quality_healing/on_creation(mob/living/new_owner, _qheal_strength)
	qheal_strength = _qheal_strength
	if(qheal_strength > 2) //Godlike food is pretty hard to achieve (Unless you're a moff) and should be rewarded
		healpwr = 5
	return ..()

/datum/status_effect/food/quality_healing/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/O = owner
	if(istype(O))
		if(O.stat == HARD_CRIT)
			return
		if(prob(5 + (qheal_strength * 2.5))) //Very tiny and in no way combat viable, might pick you up from crit in a very rare case
			O.heal_bodypart_damage(brute = healpwr, burn = healpwr, required_bodytype = BODYTYPE_ORGANIC)
			for(var/obj/item/organ/stomach/S in O.organs)
				S.apply_organ_damage((S.healing_factor * healpwr))
