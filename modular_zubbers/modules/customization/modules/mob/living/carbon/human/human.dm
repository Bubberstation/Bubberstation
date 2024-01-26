/mob/living/carbon/human/throw_item(atom/target)
	var/obj/item/held_item = get_active_held_item()

	if(HAS_TRAIT(src, TRAIT_WEAK_BODY))
		if(!held_item)
			if(pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
				var/mob/living/mob = pulling
				if(!mob.buckled)
					if(!HAS_TRAIT(mob, TRAIT_WEAK_BODY))
						stop_pulling()
						to_chat(src, span_notice("You try throwing [mob], but [mob.p_they()] is too heavy!"))
						return FALSE
	..(target)

/mob/living/carbon/human/mouse_buckle_handling(mob/living/M, mob/living/user)
	if(pulling != M || grab_state != GRAB_AGGRESSIVE || stat != CONSCIOUS)
		return FALSE

	if(buckled)
		return FALSE

	if(can_buckle_to_hand(M))
		buckle_to_hand_mob(M)
		return TRUE
	..(M, user)

/mob/living/carbon/human/fireman_carry(mob/living/carbon/target)
	if(!can_be_firemanned(target) || incapacitated(IGNORE_GRAB))
		to_chat(src, span_warning("You can't fireman carry [target] while [target.p_they()] [target.p_are()] standing!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAK_BODY))
		visible_message(span_warning("[src] tries to carry [target], but they are too heavy!"))
		return
	..(target)

/mob/living/carbon/human/piggyback(mob/living/carbon/target)
	if(!can_piggyback(target))
		to_chat(target, span_warning("You can't piggyback ride [src] right now!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAK_BODY) && !HAS_TRAIT(target, TRAIT_WEAK_BODY))
		target.visible_message(span_warning("[target] is too heavy for [src] to carry!"))
		return
	..(target)


/mob/living/carbon/human/proc/buckle_to_hand_mob(mob/living/carbon/target)
	if(!can_buckle_to_hand(target) || incapacitated(IGNORE_GRAB))
		to_chat(src, span_warning("You can't lift [target] to hand while [target.p_they()] [target.p_are()] standing!"))
		return

	var/carrydelay = 3 SECONDS
	if(HAS_TRAIT(src, TRAIT_QUICKER_CARRY) || has_quirk(/datum/quirk/oversized))
		carrydelay = 1 SECONDS
	else if(HAS_TRAIT(src, TRAIT_QUICK_CARRY))
		carrydelay = 2 SECONDS

	visible_message(span_notice("[src] starts lifting [target] onto their hand..."),
		span_notice("You start to lift [target] onto your hand..."))
	if(!do_after(src, carrydelay, target))
		visible_message(span_warning("[src] fails to lift [target] to hand!"))
		return

	if(!can_buckle_to_hand(target) || incapacitated(IGNORE_GRAB) || target.buckled)
		visible_message(span_warning("[src] fails to lift [target] to hand!"))
		return

	target.drop_all_held_items()
	return buckle_mob(target, TRUE, TRUE, CARRIER_NEEDS_ARM)

/mob/living/carbon/human/proc/can_buckle_to_hand(mob/living/carbon/target)
	if((ishuman(target) && !HAS_TRAIT(src, TRAIT_WEAK_BODY)) &&  HAS_TRAIT(target, TRAIT_CAN_BE_PICKED_UP))
		return TRUE
	return FALSE
