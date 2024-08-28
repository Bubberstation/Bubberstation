/obj/item/melee/sickly_blade/exile/upgrade
	name = "\improper Elder's insanity sword"
	desc = "A dark plasma-edged sword that flickers with strange energy. Just looking at it makes you feel uneasy."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	icon_state = "sword"

	righthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_right.dmi'
	lefthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_left.dmi'
	inhand_icon_state = "sword"

	after_use_message = "The Exile hears your call..."

	force = 24 //Previously 20
	throwforce = 5 //Previously 10
	wound_bonus = 10 //Previously 5
	bare_wound_bonus = 10 //Previously 15
	toolspeed = 0.5 //Previously 0.375
	demolition_mod = 1.2 //Previously 0.8
	armour_penetration = 50

	var/static/list/insanity_phrases = list(
		"There is something nearby.",
		"You left something behind.",
		"You hear something.",
		"They're going to kill you.",
		"I found you.",
		"I'm moving towards you.",
		"Where did you go?",
		"What are you doing?",
		"Do you have a moment?",
		"Hey.",
		"I hear them.",
		"Something is going to happen.",
		"What are you doing?",
		"I found a way.",
		"There it is.",
		"Who is that?",
		"Why?",
		"What is that?",
		"They see you.",
		"They hear you.",
		"They're watching you.",
		"Hello, chat."
	)

	var/mob/living/carbon/current_user

/obj/item/melee/sickly_blade/exile/upgrade/Destroy()
	current_user = null //Just in case.
	. = ..()

/obj/item/melee/sickly_blade/exile/upgrade/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	current_user = user
	START_PROCESSING(SSobj,src)

/obj/item/melee/sickly_blade/exile/upgrade/dropped(mob/user, silent)
	. = ..()
	current_user = null
	STOP_PROCESSING(SSobj, src)

/obj/item/melee/sickly_blade/exile/upgrade/process(seconds_per_tick)

	if(!current_user || loc != current_user) //Something went wrong.
		STOP_PROCESSING(SSobj, src)
		return

	if(SPT_PROB(3,seconds_per_tick))
		current_user.emote("laugh")
		if(!prob(80)) //hallucination optimization 1
			visible_hallucination_pulse(current_user,hallucination_duration = 30 SECONDS,optional_messages=insanity_phrases)
		else if(!prob(80)) //hallucination optimization 2
			to_chat(current_user,span_velvet(pick(insanity_phrases)))
		else
			current_user.cause_hallucination(/datum/hallucination/chat, "elder's insanity sword hallucination")

/obj/item/melee/sickly_blade/exile/upgrade/examine(mob/user)
	. = ..()
	if(!check_usability(user))
		return
	. += span_velvet("Or can you?")

/obj/item/melee/sickly_blade/exile/upgrade/afterattack(atom/target, mob/user, click_parameters)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!living_user.mob_mood)
		return

	living_user.mob_mood.set_sanity(living_user.mob_mood - 5)

	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.mob_mood)
			living_target.mob_mood.set_sanity(living_target.mob_mood - 5)


/obj/item/melee/sickly_blade/exile/upgrade/attack_self(mob/user)

	if(!isliving(user))
		return

	var/mob/living/living_user = user

	if(!living_user.mob_mood)
		return

	living_user.visible_message(
		span_warning("[user] attempts to shatter the blade, but the blade shatters their mind instead!"),
		span_danger("You attempt to shatter the blade, but the blade shatters your mind instead!")
	)

	living_user.mob_mood.set_sanity(SANITY_INSANE)
	living_user.Knockdown(2 SECONDS)
	living_user.set_jitter_if_lower(10 SECONDS)
	living_user.emote("scream")


/obj/item/melee/sickly_blade/exile/upgrade/check_usability(mob/living/user)
	return TRUE