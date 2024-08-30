#define PERSONAL_SPACE_DAMAGE 2
#define ASS_SLAP_EXTRA_RANGE -1

/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == dir)
		if(HAS_TRAIT(target, TRAIT_STEEL_ASS))
			var/obj/item/bodypart/affecting = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(affecting?.receive_damage(PERSONAL_SPACE_DAMAGE))
				update_damage_overlays()
				emote("scream")
			var/list/ouchies = list(
				'modular_zzplurt/sound/effects/pan0.ogg',
				'modular_zzplurt/sound/effects/pan1.ogg'
			)
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
		playsound(target.loc, 'sound/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)

	. = ..()

#undef ASS_SLAP_EXTRA_RANGE
#undef PERSONAL_SPACE_DAMAGE
