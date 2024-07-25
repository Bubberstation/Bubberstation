GLOBAL_LIST_INIT(digest_modes, init_digest_modes())

/proc/init_digest_modes()
	var/list/digest_modes = list()
	for(var/datum/digest_mode/digest_mode as anything in subtypesof(/datum/digest_mode))
		var/datum/digest_mode/DM = new digest_mode()
		digest_modes[DM.name] = DM
	return digest_modes

/datum/digest_mode
	var/name = ""

/datum/digest_mode/proc/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	return

/datum/digest_mode/none
	name = DIGEST_MODE_NONE

/datum/digest_mode/digest
	name = DIGEST_MODE_DIGEST

/mob/living/proc/vore_can_negatively_affect()
	#if REQUIRES_PLAYER
	// No player, no deal
	return FALSE
	#else
	if(mind)
		// they were at some point a player, we don't digest them until they get back
		return FALSE
	// Animal, melt em
	return TRUE
	#endif

/mob/living/proc/vore_can_digest()
	if(client)
		var/datum/vore_preferences/vore_prefs = client.get_vore_prefs()
		return vore_prefs?.read_preference(/datum/vore_pref/toggle/digestion)

	return vore_can_negatively_affect()

/mob/living/proc/vore_can_qdel()
	if(client)
		var/datum/vore_preferences/vore_prefs = client.get_vore_prefs()
		return vore_prefs?.read_preference(/datum/vore_pref/toggle/digestion_qdel)

	return vore_can_negatively_affect()

/datum/digest_mode/digest/handle_belly(obj/vore_belly/vore_belly, seconds_per_tick)
	var/mob/living/living_parent = vore_belly.owner.parent
	if(COOLDOWN_FINISHED(vore_belly, noise_cooldown))
		if(LAZYLEN(vore_belly.contents) && prob(50))
			var/prey_sound = null
			var/pred_sound = null
			if(vore_belly.fancy_sounds)
				prey_sound = "vore_sounds_digestion_fancy_prey"
				pred_sound = "vore_sounds_digestion_fancy"
			else
				prey_sound = "vore_sounds_digestion_classic"
				pred_sound = "vore_sounds_digestion_classic"
			vore_belly.play_vore_sound_preypred(prey_sound, pred_sound, pref = /datum/vore_pref/toggle/digestion_noises)
			COOLDOWN_START(vore_belly, noise_cooldown, DIGESTION_NOISE_COOLDOWN)

	for(var/mob/living/L in vore_belly)
		if(!L.vore_can_digest())
			continue
		if(L.stat == DEAD)
			if(L.vore_can_qdel())
				if(vore_belly.fancy_sounds)
					vore_belly.play_vore_sound_preypred("vore_sounds_death_fancy_prey", "vore_sounds_death_fancy", pref = /datum/vore_pref/toggle/digestion_noises)
				else
					vore_belly.play_vore_sound_preypred("vore_sounds_death_classic", "vore_sounds_death_classic", pref = /datum/vore_pref/toggle/digestion_noises)
				living_parent.adjust_nutrition(NUTRITION_PER_KILL)
				qdel(L)
			continue
		if(vore_belly.brute_damage > 0)
			L.adjustBruteLoss(vore_belly.brute_damage * seconds_per_tick)
			living_parent.adjust_nutrition(NUTRITION_PER_DAMAGE * vore_belly.brute_damage * seconds_per_tick)
		if(vore_belly.burn_damage > 0)
			L.adjustFireLoss(vore_belly.burn_damage * seconds_per_tick)
			living_parent.adjust_nutrition(NUTRITION_PER_DAMAGE * vore_belly.burn_damage * seconds_per_tick)
