#define EXPLOSION_DAMAGE_LIGHT 40
#define EXPLOSION_DAMAGE_HEAVY 120
#define EXPLOSION_DAMAGE_DEVASTATE 600

/mob/living/carbon/human/ex_act(severity, target, origin)

	if(HAS_TRAIT(src, TRAIT_BOMBIMMUNE))
		return FALSE

	var/list/obj/item/bodypart/possible_parts = get_damageable_bodyparts()

	var/possible_parts_length = length(possible_parts)

	if(!possible_parts_length) //Some fucked up chicken mcnugget species or something.
		return ..()

	possible_parts = shuffle(possible_parts)

	var/attack_direction = get_dir(src,origin)

	var/brute_loss = 0
	var/burn_loss = 0
	var/armor_penetration = 0
	var/maximum_dismemberments = 0

	switch(severity)
		if(EXPLODE_LIGHT)
			brute_loss = EXPLOSION_DAMAGE_LIGHT
			maximum_dismemberments = rand(0.1)
		if(EXPLODE_HEAVY)
			brute_loss = EXPLOSION_DAMAGE_HEAVY*0.5
			burn_loss = EXPLOSION_DAMAGE_HEAVY*0.5
			armor_penetration = EXPLODE_GIB_THRESHOLD*0.5
			maximum_dismemberments = rand(0,2)
		if(EXPLODE_DEVASTATE)
			brute_loss = EXPLOSION_DAMAGE_DEVASTATE*0.5
			burn_loss = EXPLOSION_DAMAGE_DEVASTATE*0.5
			armor_penetration = EXPLODE_GIB_THRESHOLD
			maximum_dismemberments = rand(0,4) //chimken nuget

	var/flat_brute_loss = brute_loss*(1/possible_parts_length)*0.5 //Always deal this amount per part.
	var/flat_burn_loss = burn_loss*(1/possible_parts_length)*0.5 //Always deal this amount per part.
	brute_loss -= flat_brute_loss*possible_parts_length
	burn_loss -= flat_burn_loss*possible_parts_length

	var/total_damage_dealt = 0
	var/parts_left = possible_parts_length
	for(var/obj/item/bodypart/limb as anything in possible_parts)

		var/part_mod = 1 - (parts_left/possible_parts_length)
		parts_left--

		var/random_brute_damage_to_deal = brute_loss > 0 ? rand( part_mod*brute_loss, brute_loss) : 0
		var/random_burn_damage_to_deal = burn_loss > 0 ? rand( part_mod*burn_loss, burn_loss) : 0
		brute_loss -= random_brute_damage_to_deal
		burn_loss -= random_burn_damage_to_deal

		var/armor_to_use = max(0,getarmor(limb, BOMB) - armor_penetration)

		var/old_brute = limb.brute_dam
		var/old_burn = limb.burn_dam

		limb.receive_damage(
			flat_brute_loss + random_brute_damage_to_deal,
			flat_burn_loss + random_burn_damage_to_deal,
			armor_to_use,
			updating_health = FALSE,
			attack_direction = attack_direction,
			damage_source = origin
		)

		var/limb_damage_dealt = (limb.brute_dam + limb.burn_dam) - (old_brute + old_burn)
		total_damage_dealt += limb_damage_dealt

		//Handle dismemberment here, if it already wasn't somehow dismembered by damage.
		if( (limb.loc != src && !QDELETED(limb)) || ((total_damage_dealt >= limb.max_damage*0.75) && maximum_dismemberments > 0 && limb.can_be_disabled && limb.try_dismember(WOUND_BLUNT,limb_damage_dealt,0,0)) ) //Limb was removed. Make it fly.
			SSexplosions.high_mov_atom += limb
			maximum_dismemberments--


	if(total_damage_dealt > EXPLOSION_DAMAGE_DEVASTATE*0.95) //Not enough damage to protect you. The 95% multiplier is a little bit of forgiveness in case of rounding errors.
		for(var/atom/movable/oh_no_my_organs as anything in contents)
			SSexplosions.high_mov_atom += oh_no_my_organs
		investigate_log("has been gibbed by an explosion.", INVESTIGATE_DEATHS)
		gib(DROP_ALL_REMAINS)
		return TRUE

	if(total_damage_dealt > 0)
		//Handle clothing damage.
		damage_clothes(total_damage_dealt, BRUTE, BOMB)

		//Handle knockdown
		var/knockdown_amount = (4 SECONDS) * (total_damage_dealt / EXPLOSION_DAMAGE_LIGHT)
		if(knockdown_amount >= 2 SECONDS )
			Knockdown( knockdown_amount)

		//Handle unconscious
		var/unconscious_amount = (2 SECONDS) * (total_damage_dealt / EXPLOSION_DAMAGE_HEAVY)
		if(unconscious_amount > 1 SECONDS)
			Unconscious( unconscious_amount )

		//Handle ear damage and deafness.
		if(!HAS_TRAIT_FROM_ONLY(src, TRAIT_DEAF, EAR_DAMAGE))
			var/obj/item/organ/ears/ears = get_organ_slot(ORGAN_SLOT_EARS)
			if(ears)
				var/ear_damage_amount = 30 * (total_damage_dealt / EXPLOSION_DAMAGE_LIGHT)
				var/deafness_damage_amount = 120 * (total_damage_dealt / EXPLOSION_DAMAGE_LIGHT)
				if(ear_damage_amount >= 15 && total_damage_dealt >= 60)
					ears.adjustEarDamage(ear_damage_amount, deafness_damage_amount)

		updatehealth()

	return TRUE

#undef EXPLOSION_DAMAGE_LIGHT
#undef EXPLOSION_DAMAGE_HEAVY
#undef EXPLOSION_DAMAGE_DEVASTATE
