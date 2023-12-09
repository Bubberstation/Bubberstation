#define BLOBMOB_BLOBBERNAUT_MAX_RAMPUP 5

/mob/living/basic/blob_minion/blobbernaut/minion
	var/damage_rampup = 0


// Redoes the whole blobbernaut funzies with rushing across the hallway with no real risk to yourself
/mob/living/basic/blob_minion/blobbernaut/minion/Life(seconds_per_tick, times_fired)
	. = ..()
	if (!.)
		return FALSE
	CalculateDamageRampup()

	if(damage_rampup == 0)
		return
	// Healing is handled by negative rampup to prevent too much copypaste code
	if(damage_rampup < 0)
		// These are made to substitute BLOBMOB_BLOBBERNAUT_HEALING_CORE and BLOBMOB_BLOBBERNAUT_HEALING_NODE
		heal_overall_damage(maxHealth * abs(damage_rampup) * seconds_per_tick)
		var/obj/effect/temp_visual/heal/heal_effect = new /obj/effect/temp_visual/heal(get_turf(src))
		heal_effect.color = atom_colours[FIXED_COLOUR_PRIORITY] || COLOR_BLACK
	else if(damage_rampup > 0)
		// take 2.5% of max health per damage rampup point
		apply_damage(maxHealth * BLOBMOB_BLOBBERNAUT_HEALTH_DECAY * damage_rampup * seconds_per_tick, damagetype = TOX) // We reduce brute damage
		var/mutable_appearance/harming = mutable_appearance('icons/mob/nonhuman-player/blob.dmi', "nautdamage", MOB_LAYER + 0.01)
		harming.appearance_flags = RESET_COLOR
		harming.color = atom_colours[FIXED_COLOUR_PRIORITY] || COLOR_WHITE
		harming.dir = dir
		flick_overlay_view(harming, 0.8 SECONDS)
	return

// Calculates the rampup
/mob/living/basic/blob_minion/blobbernaut/minion/proc/CalculateDamageRampup()
	if(orphaned)
		damage_rampup = BLOBMOB_BLOBBERNAUT_MAX_RAMPUP
		return
	if(locate(/obj/structure/blob) in range(4, src))
		var/list/blob_healing_area = range(2, src)
		// You get core healing everywhere, as compensation
		if(locate(/obj/structure/blob/special/core) in blob_healing_area || locate(/obj/structure/blob/special/node) in blob_healing_area)
			damage_rampup = -BLOBMOB_BLOBBERNAUT_HEALING_CORE
		else
			damage_rampup = 0
	else
		damage_rampup += 1
	return

#undef BLOBMOB_BLOBBERNAUT_MAX_RAMPUP
