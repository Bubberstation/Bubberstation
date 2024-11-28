#define KISS_COOLDOWN (0.4 SECONDS)

/mob/living
	COOLDOWN_DECLARE(restricted_emote_cooldown)

/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!COOLDOWN_FINISHED(user, restricted_emote_cooldown))
		user.balloon_alert(user, "kiss on cooldown!")
		return

	var/kiss_type = /obj/item/hand_item/kisser
	var/kiss_cooldown = KISS_COOLDOWN

	if(HAS_TRAIT(user, TRAIT_SYNDIE_KISS))
		kiss_type = /obj/item/hand_item/kisser/syndie
		kiss_cooldown = KISS_COOLDOWN * 4

	if(HAS_TRAIT(user, TRAIT_KISS_OF_DEATH))
		kiss_type = /obj/item/hand_item/kisser/death
		kiss_cooldown = KISS_COOLDOWN * 4

	var/obj/item/kiss_blower = new kiss_type(user)
	if(user.put_in_hands(kiss_blower))
		user.balloon_alert(user, "kiss ready!")
		COOLDOWN_START(user, restricted_emote_cooldown, kiss_cooldown)
	else
		qdel(kiss_blower)
		to_chat(user, span_warning("You're incapable of blowing a kiss in your current state."))

#undef KISS_COOLDOWN
