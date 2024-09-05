/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/kiss_type = /obj/item/hand_item/kisser

	if(do_after(user, 0.55 SECONDS, target = user, timed_action_flags = IGNORE_USER_LOC_CHANGE))//bubber edit addition
		if(HAS_TRAIT(user, TRAIT_SYNDIE_KISS))
			kiss_type = /obj/item/hand_item/kisser/syndie

		if(HAS_TRAIT(user, TRAIT_KISS_OF_DEATH))
			kiss_type = /obj/item/hand_item/kisser/death

		var/obj/item/kiss_blower = new kiss_type(user)
		if(user.put_in_hands(kiss_blower))
			to_chat(user, span_notice("You ready your kiss-blowing hand."))
		else
			qdel(kiss_blower)
			to_chat(user, span_warning("You're incapable of blowing a kiss in your current state."))
	else
		return
