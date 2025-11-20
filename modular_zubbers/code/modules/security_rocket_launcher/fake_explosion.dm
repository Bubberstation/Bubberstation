//Makes a fake 3x3 explosion centered around the origin. Doesn't delimb or use explosion code (other than calling act_ex on non-living objects).
//Other than the custom damage, this is similiar to calling EXPLODE_LIGHT.

/proc/fake_explode(atom/origin, explosion_damage=30, atom/cause)

	var/turf/our_turf = isturf(origin) ? origin : get_turf(origin)

	//Fake explosion code. Doesn't delimb humans.
	for(var/atom/victim as anything in view(1, our_turf))
		if(!isliving(victim))
			if(!(SEND_SIGNAL(victim, COMSIG_ATOM_PRE_EX_ACT, EXPLODE_LIGHT) & COMPONENT_CANCEL_EX_ACT))
				SEND_SIGNAL(victim, COMSIG_ATOM_EX_ACT, EXPLODE_LIGHT)
				victim.ex_act(EXPLODE_LIGHT)
			continue
		var/mob/living/victim_as_living = victim
		if(HAS_TRAIT(victim_as_living, TRAIT_BOMBIMMUNE))
			continue
		//Do the damage.
		victim_as_living.apply_damage(
			explosion_damage,
			BRUTE,
			BODY_ZONE_CHEST,
			victim_as_living.getarmor(null, BOMB),
			FALSE,
			TRUE,
			0,
			0,
			NONE,
			get_dir(our_turf, victim),
			cause ? cause : origin,
			TRUE
		)
		//Do the knockdown
		victim_as_living.Knockdown(2 SECONDS)
		//Do the ear damage
		if(!HAS_TRAIT_FROM_ONLY(victim_as_living, TRAIT_DEAF, EAR_DAMAGE))
			victim_as_living.sound_damage(15, 120 SECONDS)

		continue

	playsound(our_turf, SFX_EXPLOSION, 30, TRUE)
