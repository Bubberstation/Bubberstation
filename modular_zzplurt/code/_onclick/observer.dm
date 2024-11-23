/mob/living/carbon/human/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(. || !user.client)
		return
	if(!(isAdminGhostAI(user) || user.client.prefs.read_preference(/datum/preference/toggle/inquisitive_ghost)) && CONFIG_GET(flag/ghost_interaction))
		return
	ghost_ass_slap(user)

/mob/living/carbon/human/proc/ghost_ass_slap(mob/dead/observer/user)
	// Check if target is alive
	if(stat >= DEAD)
		// Alert ghost and return
		to_chat(user, "Your ethereal hand phases through \The [src]. This will only work on the living.")
		return

	// Check for Personal Space (formally Buns of Steel)
	if(HAS_TRAIT(src, TRAIT_PERSONALSPACE))
		// Display messages
		visible_message(\
			span_danger("[src]'s ass clangs as though it were being smacked, but nobody is there."),
			span_danger("You feel something bounce off your steely asscheeks, but nothing is there..."),
			"You hear a loud clang!", null, user)
		to_chat(user, span_notice("You try to slap \The [src]'s ass, but your ethereal hand bounces right off!"))

		// Play reflect sound
		playsound(src.loc, get_sfx_skyrat(SFX_BULLET_IMPACT_METAL), 50, 1, -1)

		return

	/*
	if(!HAS_TRAIT(src, TRAIT_PERMABONER))
		H.dna.species.stop_wagging_tail(src)
	*/

	// Play slap sound
	conditional_pref_sound(src.loc, 'sound/items/weapons/slap.ogg', 50, 1, -1)

	// Display standard message
	visible_message(\
		span_danger("You hear someone slap \The [src]'s ass, but nobody's there..."),
		span_notice("Somebody slaps your ass, but nobody is around..."),
		"You hear a spooky slap.", null, user)
	to_chat(user, span_notice("You manage to will your ethereal hand to slap \The [src]'s ass."))

	// Check for slapping quirk
	if(HAS_TRAIT(src, TRAIT_JIGGLY_ASS))
		// Check for non-con pref
		if(READ_PREFS(src, choiced/erp_status_nc) != "Yes")
			// Don't do it
			return

		// Add arousal
		adjust_arousal(10)
