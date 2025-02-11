/datum/physiology
	var/flat_brute_mod = 0
	var/flat_burn_mod = 0

/mob/living/carbon/human/get_incoming_damage_modifier(
	damage = 0,
	damagetype = BRUTE,
	def_zone = null,
	sharpness = NONE,
	attack_direction = null,
	attacking_item,
)
	var/final_mod = ..()
	if(!physiology)
		return final_mod

	switch(damagetype)
		if(BRUTE)
			final_mod -= physiology.flat_brute_mod
		if(BURN)
			final_mod -= physiology.flat_burn_mod

	return final_mod
