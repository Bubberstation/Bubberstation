/obj/item/hand_item/bonkinghand
	name = "bonking hand"
	desc = "Time to bonk someone over the head in comedic fashion."
	inhand_icon_state = "nothing"
	attack_verb_continuous = list("bonks")
	attack_verb_simple = list("bonk")
	hitsound = 'sound/effects/snap.ogg'

/obj/item/hand_item/bonkinghand/Initialize(mapload)
	. = ..()

/obj/item/hand_item/bonkinghand/attack(mob/living/bonked, mob/living/carbon/human/user)
	var/bonk_volume = 75
	var/obj/item/bodypart/bonkers_hand = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	var/obj/item/bodypart/head/bonk_victims_head = bonked.get_bodypart(BODY_ZONE_HEAD)
	if(user.zone_selected != BODY_ZONE_HEAD)
		to_chat(user, span_warning("You can't bonk someone on the head if you aren't aiming for their head!"))
		return

	if(issilicon(bonked))
		if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
			user.update_damage_overlays()
		user.visible_message(
			span_danger("[user] bonks [bonked] on the head, leaving their hand red and swollen!"),
			span_notice("You bonk [bonked] on the head, but hurt your hand on the metal of their head!"),
			span_hear("You hear a comedic metallic bonk."),
		)
		playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, TRUE, -1)

	else if(bonk_victims_head)
		if(bonk_victims_head.biological_state & BIO_METAL)
			if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
				user.update_damage_overlays()
			user.visible_message(
				span_danger("[user] bonks [bonked] on the head, leaving their hand red and swollen!"),
				span_notice("You bonk [bonked] on the head, but hurt your hand on the metal of their head!"),
				span_hear("You hear a comedic metallic bonk."),
			)
			playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, FALSE, -1)

		else
			user.visible_message(
				span_danger("[user] bonks [bonked] on the head!"),
				span_notice("You bonk [bonked] on the head!"),
				span_hear("You hear a comedic bonking sound."),
			)
			playsound(bonked, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', bonk_volume, FALSE, -1)
	else
		to_chat(user, span_warning("You can't bonk someone on the head if they have no head!"))
		return
	qdel(src)
// Successful takes will qdel our hand after
/obj/item/hand_item/bonkinghand/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(!.)
		return

	qdel(src)

