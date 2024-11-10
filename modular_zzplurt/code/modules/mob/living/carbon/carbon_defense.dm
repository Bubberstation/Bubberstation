#define ASS_SLAP_EXTRA_RANGE -1
#define BADTOUCH_RETALIATE_CHANCE 5
#define BADTOUCH_RETALIATE_DAMAGE 5
#define BADTOUCH_RETALIATE_KNOCKDOWN 20
#define BADTOUCH_RETALIATE_SADISM_MULT 2
#define ASS_JIGGLE_COOLDOWN 10 SECONDS
#define ASS_JIGGLE_STAMLOSS 25
#define ASS_JIGGLE_VERBS_1 pick("rippling","jiggling","sloshing","clapping","wobbling")
#define ASS_JIGGLE_VERBS_2 pick("ripples","jiggles","sloshes","claps","wobbles")

/mob/living/carbon/disarm(mob/living/carbon/target)
	// Check if targeting the groin
	if(!(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == dir))
		// Nothing to do here!
		// Run original
		. = ..()
		return

	// Check for personal space
	if(HAS_TRAIT(target, TRAIT_PERSONALSPACE))
		// Attempt to retaliate
		// No check, because this is autonomous
		target.do_touch_retaliate(src)

		// Play reflect sound
		playsound(target.loc, get_sfx_skyrat(SFX_BULLET_IMPACT_METAL), 50, TRUE, ASS_SLAP_EXTRA_RANGE)

		// Display messages
		visible_message(
			span_danger("[src] tries to slap [target]'s ass, but [src.p_their()] hand bounces off it like solid steel!"),
			span_danger("You try to slap [target]'s ass, but your hand bounces off it like solid steel!"),
			"You hear a loud clang!",
			ignored_mobs = list(target)
		)
		to_chat(target, span_danger("[src] tries to slap your ass, but [src.p_their()] hand bounces off it!"))

		// End here
		return

	// Check for slap request
	if(HAS_TRAIT(target, TRAIT_JIGGLY_ASS))
		// Get target quirk
		var/datum/quirk/jiggly_ass/quirk_jiggle = target.get_quirk(/datum/quirk/jiggly_ass)

		// Check for cooldown
		if(!COOLDOWN_FINISHED(quirk_jiggle, wiggle_cooldown))
			// Display message
			target.visible_message(span_warning("[target]'s big butt is still [ASS_JIGGLE_VERBS_1] about way too much to get a good smack!!"), \
			span_boldwarning("[src] tries to smack your jiggly ass, but can't get a lock on it!"))

			// End here
			return

		// Cooldown is not active
		// Start the cooldown
		COOLDOWN_START(quirk_jiggle, wiggle_cooldown, ASS_JIGGLE_COOLDOWN)

		// Add mood bonuses
		add_mood_event(QMOOD_JIGGLY_ASS, /datum/mood_event/butt_slap)
		target.add_mood_event(QMOOD_JIGGLY_ASS, /datum/mood_event/butt_slapped)

		// Reduce target stamina (???)
		target.adjustStaminaLoss(ASS_JIGGLE_STAMLOSS)

		// Display message
		visible_message(
			span_purple("[src] slaps [target] right on the ass, and sends it [ASS_JIGGLE_VERBS_1]!"),
			span_purple("You slap [target] on the ass, and send it [ASS_JIGGLE_VERBS_1]! How satisfying!"),
			"You hear a slap.",
			ignored_mobs = list(target)
		)
		to_chat(target, span_purple("[src] smacks your big fat butt, and sends it [ASS_JIGGLE_VERBS_1]! It [ASS_JIGGLE_VERBS_2] about and throws you off balance!"))

		// Apply effects
		do_ass_slap_animation(target)
		conditional_pref_sound(target.loc, 'sound/items/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)

	// Run original
	. = ..()

/mob/living/carbon/adjustOxyLoss(amount, updating_health = TRUE, forced, required_biotype, required_respiration_type)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Check for Choke Slut
	if(HAS_TRAIT(src, TRAIT_CHOKE_SLUT))
		// Check if amount is positive
		// Negative values remove suffocation
		if(amount < 0)
			return

		// Check if alive and ERP is enabled
		if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
			return

		// Check for no breathing
		if(HAS_TRAIT(src, TRAIT_NOBREATH))
			return

		// Define quirk mob
		var/mob/living/carbon/human/quirk_mob = src

		// Check if quirk mob exists
		if(!quirk_mob)
			return

		// Adjust arousal
		quirk_mob.adjust_arousal(amount)

/mob/living/carbon/proc/can_touch_retaliate()
	// User must be conscious
	if(src.stat != CONSCIOUS)
		// Do nothing
		return FALSE

	// User cannot be handcuffed
	if(src.handcuffed)
		return FALSE

	// User cannot be a pacifist
	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		return FALSE

	// User can retaliate
	return TRUE

/mob/living/carbon/proc/do_touch_retaliate(mob/living/carbon/toucher)
	// Check if toucher enjoys this
	if(HAS_TRAIT(toucher, TRAIT_MASOCHISM))
		// Cause toucher to express contentment
		toucher.try_lewd_autoemote("moan")

		// Add good mood event
		toucher.add_mood_event(QMOOD_BADTOUCH_VICTIM, /datum/mood_event/badtouch_retaliate/victim_good)

	// They don't enjoy this
	else
		// Cause toucher to scream
		toucher.emote("scream")

		// Add bad mood event
		toucher.add_mood_event(QMOOD_BADTOUCH_VICTIM, /datum/mood_event/badtouch_retaliate/victim_bad)

	// Damage amount to apply
	var/retaliate_damage = BADTOUCH_RETALIATE_DAMAGE

	// Check if target is a sadist
	if(HAS_TRAIT(src, TRAIT_SADISM))
		// Multiply retaliation damage
		retaliate_damage *= BADTOUCH_RETALIATE_SADISM_MULT

		// Add good mood event
		src.add_mood_event(QMOOD_BADTOUCH_ATTACKER, /datum/mood_event/badtouch_retaliate/attacker_good)

	// Target is not a sadist
	else
		// Add bad mood event
		src.add_mood_event(QMOOD_BADTOUCH_ATTACKER, /datum/mood_event/badtouch_retaliate/attacker_bad)

	// Determine toucher's hand
	var/which_hand = BODY_ZONE_PRECISE_L_HAND
	if(!(toucher.active_hand_index % 2))
		which_hand = BODY_ZONE_PRECISE_R_HAND

	// Apply damage to toucher's hand
	toucher.apply_damage(retaliate_damage, BRUTE, which_hand)

	// Log interaction
	log_combat(src, toucher, "retaliates against", "automatically due to a no-touching trait.")

	// Return success
	return TRUE

// Proc to recreate old Distant quirk
/mob/living/carbon/proc/badtouch_retaliate(mob/living/carbon/toucher)
	// Check for activation chance
	if(!prob(BADTOUCH_RETALIATE_CHANCE))
		// Do nothing!
		return

	// Check if this is allowed
	if(!can_touch_retaliate())
		// Do nothing
		return

	// Attempt to retaliate
	src.do_touch_retaliate(toucher)

	// Play attack sound
	playsound(get_turf(src), 'sound/effects/wounds/crack1.ogg', 50, 1, -1)

	// Display message
	toucher.visible_message(span_warning("[src] twists [toucher]\'s arm in retaliation for touching [p_them()]!"), \
		span_boldwarning("Your arm gets twisted in [src]\'s grasp!"))

	// Drop toucher's held item
	toucher.dropItemToGround(toucher.get_active_held_item())

	// Knock down toucher
	toucher.Knockdown(BADTOUCH_RETALIATE_KNOCKDOWN)

// Bad Touch retaliate mood events
/datum/mood_event/badtouch_retaliate/attacker_bad
	description = span_danger("Someone got hurt because of me.")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/attacker_good
	description = span_purple("I taught someone a lesson.")
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/victim_bad
	description = span_danger("I shouldn't touch people without permission.")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/victim_good
	description = span_purple("I deserved that for what I did.")
	mood_change = 2
	timeout = 2 MINUTES

#undef ASS_SLAP_EXTRA_RANGE
#undef BADTOUCH_RETALIATE_CHANCE
#undef BADTOUCH_RETALIATE_DAMAGE
#undef BADTOUCH_RETALIATE_KNOCKDOWN
#undef BADTOUCH_RETALIATE_SADISM_MULT
#undef ASS_JIGGLE_COOLDOWN
#undef ASS_JIGGLE_STAMLOSS
#undef ASS_JIGGLE_VERBS_1
#undef ASS_JIGGLE_VERBS_2
