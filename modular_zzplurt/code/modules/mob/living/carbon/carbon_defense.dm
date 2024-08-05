/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == src.dir)
		if(HAS_TRAIT(target, TRAIT_STEEL_ASS))
			var/obj/item/bodypart/affecting = src.get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(affecting?.receive_damage(PERSONAL_SPACE_DAMAGE))
				update_damage_overlays()
				emote("scream")
			var/list/ouchies = list(
				'modular_zzplurt/sound/effects/pan0.ogg',
				'modular_zzplurt/sound/effects/pan1.ogg'
			)
			playsound(target.loc, , 50, TRUE, ASS_SLAP_EXTRA_RANGE)
			visible_message(span_danger("[src] slaps [target]'s ass, but it's like solid steel!"),
			span_danger("You slap [target]'s ass, but it feels like solid steel!"),
			"You hear a loud clang!", ignored_mobs = list(target))
			to_chat(target, span_danger("[src] slaps your ass, but their hand bounces off like steel!"))
			return
	else if
		
	. = ..()

