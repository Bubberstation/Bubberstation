#define PERSONAL_SPACE_DAMAGE 2
#define ASS_SLAP_EXTRA_RANGE -1
#define BADTOUCH_RETALIATE_CHANCE 5
#define BADTOUCH_RETALIATE_DAMAGE 5
#define BADTOUCH_RETALIATE_KNOCKDOWN 20
#define BADTOUCH_RETALIATE_SADISM_MULT 2

/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == dir)
		if(HAS_TRAIT(target, TRAIT_STEEL_ASS))
			var/obj/item/bodypart/affecting = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(affecting?.receive_damage(PERSONAL_SPACE_DAMAGE))
				update_damage_overlays()
				emote("scream")
			/*
			var/list/ouchies = list(
				'modular_zzplurt/sound/effects/pan0.ogg',
				'modular_zzplurt/sound/effects/pan1.ogg'
			)
			*/
			playsound(target.loc, , 50, TRUE, ASS_SLAP_EXTRA_RANGE)
			visible_message(
				span_danger("[src] slaps [target]'s ass, but it's like solid steel!"),
				span_danger("You slap [target]'s ass, but it feels like solid steel!"),
				"You hear a loud clang!",
				ignored_mobs = list(target)
			)
			to_chat(target, span_danger("[src] slaps your ass, but their hand bounces off like steel!"))
			return
	else if(HAS_TRAIT(target, TRAIT_JIGGLY_ASS))
		var/datum/quirk/jiggly_ass/trait = target.get_quirk(/datum/quirk/jiggly_ass)
		if(!COOLDOWN_FINISHED(trait, wiggle_cooldown))
			if(src == target)
				to_chat(src, span_alert("Your butt is still [pick("rippling","jiggling","sloshing","clapping","wobbling")] about way too much to get a good smack!"))
			else
				to_chat(src, span_alert("[target]'s big butt is still [pick("rippling","jiggling","sloshing","clapping","wobbling")] about way too much to get a good smack!"))
		else
			COOLDOWN_START(trait, wiggle_cooldown, 10 SECONDS)
			if(src == target)
				adjustStaminaLoss(25)
				visible_message(
					span_notice("[src] gives [p_their()] butt a smack!"),
					span_purple("You give your big fat butt a smack! It [pick("ripples","jiggles","sloshes","claps","wobbles")] about and throws you off balance!"),
				)
				return
			else
				add_mood_event("ass", /datum/mood_event/butt_slap)
				target.add_mood_event("ass", /datum/mood_event/butt_slapped)
				target.adjustStaminaLoss(25)
				visible_message(
					span_danger("[src] slaps [target] right on the ass and sends it [pick("rippling","jiggling","sloshing","clapping","wobbling")]!"),
					span_notice("You slap [target] on the ass and send it [pick("rippling","jiggling","sloshing","clapping","wobbling")], how satisfying."),
					"You hear a slap.",
					ignored_mobs = list(target)
				)
				to_chat(target, span_purple("[src] smacks your big fat butt and sends it [pick("rippling","jiggling","sloshing","clapping","wobbling")]! It [pick("ripples","jiggles","sloshes","claps","wobbles")] about and throws you off balance!"))
		do_ass_slap_animation(target)
		playsound(target.loc, 'sound/items/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)

	. = ..()

// Proc to recreate old Distant quirk
/mob/living/carbon/proc/badtouch_retaliate(mob/living/carbon/toucher)
	// Check for activation chance
	if(!prob(BADTOUCH_RETALIATE_CHANCE))
		// Do nothing!
		return

	// User cannot be a pacifist
	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		// Alert user and return
		to_chat(src, span_warning("You briefly consider retaliating against [toucher], but decide not to."))
		return

	// Display message
	toucher.visible_message(span_warning("[src] twists [toucher]\'s arm in retaliation for touching [p_them()]!"), \
		span_boldwarning("Your arm gets twisted in [src]\'s grasp!"))

	// Play attack sound
	playsound(get_turf(src), 'sound/effects/wounds/crack1.ogg', 50, 1, -1)

	// Damage amount to apply
	var/retaliate_damage = BADTOUCH_RETALIATE_DAMAGE

	// Check if toucher enjoys this
	if(HAS_TRAIT(toucher, TRAIT_MASOCHISM))
		// Cause toucher to express contentment
		toucher.emote("moan")

		// Add good mood event
		toucher.add_mood_event("badtouch_retaliate_victim", /datum/mood_event/badtouch_retaliate/victim_good)

	// They don't enjoy this
	else
		// Cause toucher to scream
		toucher.emote("scream")

		// Add bad mood event
		toucher.add_mood_event("badtouch_retaliate_victim", /datum/mood_event/badtouch_retaliate/victim_bad)

	// Check if target is a sadist
	if(HAS_TRAIT(src, TRAIT_SADISM))
		// Multiply retaliation damage
		retaliate_damage *= BADTOUCH_RETALIATE_SADISM_MULT

		// Add good mood event
		src.add_mood_event("badtouch_retaliate_attacker", /datum/mood_event/badtouch_retaliate/attacker_good)

	// Target is not a sadist
	else
		// Add bad mood event
		src.add_mood_event("badtouch_retaliate_attacker", /datum/mood_event/badtouch_retaliate/attacker_good)

	// Drop toucher's held item
	toucher.dropItemToGround(toucher.get_active_held_item())

	// Determine toucher's hand
	var/which_hand = BODY_ZONE_PRECISE_L_HAND
	if(!(toucher.active_hand_index % 2))
		which_hand = BODY_ZONE_PRECISE_R_HAND

	// Apply damage to toucher's hand
	toucher.apply_damage(retaliate_damage, BRUTE, which_hand)

	// Knock down toucher
	toucher.Knockdown(BADTOUCH_RETALIATE_KNOCKDOWN)

	// Log interaction
	log_combat(src, toucher, "retaliates against", "due to Bad Touch quirk")

// Bad Touch retaliate mood events
/datum/mood_event/badtouch_retaliate/attacker_bad
	description = "I need to watch my temper."
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/attacker_good
	description = "I taught someone a lesson."
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/victim_bad
	description = "I shouldn't touch people without permission."
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/badtouch_retaliate/victim_good
	description = "I deserved that for what I did."
	mood_change = 2
	timeout = 2 MINUTES

#undef ASS_SLAP_EXTRA_RANGE
#undef PERSONAL_SPACE_DAMAGE
#undef BADTOUCH_RETALIATE_CHANCE
#undef BADTOUCH_RETALIATE_DAMAGE
#undef BADTOUCH_RETALIATE_KNOCKDOWN
#undef BADTOUCH_RETALIATE_SADISM_MULT
