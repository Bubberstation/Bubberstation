/datum/physiology
	var/flat_brute_mod = 0
	var/flat_burn_mod = 0

/mob/living/carbon/human/apply_damage(
		damage,
		damagetype,
		def_zone,
		blocked,
		forced,
		spread_damage,
		wound_bonus,
		bare_wound_bonus,
		sharpness,
		attack_direction,
		attacking_item,
		wound_clothing
	)
	if(!physiology)
		return ..()

	switch(damagetype)
		if(BRUTE)
			damage += physiology.flat_brute_mod
		if(BURN)
			damage += physiology.flat_burn_mod

	. = ..()
