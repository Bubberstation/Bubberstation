/obj/item/melee/sickly_blade/exile/upgrade
	name = "\improper Elder's insanity sword"
	desc = "A dark plasma-edged sword that flickers with strange energy. Just looking at it makes you feel uneasy."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	icon_state = "sword"

	righthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_right.dmi'
	lefthand_file = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inhand_left.dmi'
	inhand_icon_state = "sword"

	after_use_message = "The Exile hears your call..."

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

	w_class = WEIGHT_CLASS_BULKY

	//Same stats as a captain's sabre, minus the blockchance (25 as opposed to captain's 50)
	force = 20
	throwforce = 10
	wound_bonus = 10
	bare_wound_bonus = 25
	armour_penetration = 25

	block_chance = 25

	sharpness = SHARP_EDGED

	block_sound = 'sound/weapons/parry.ogg'
	hitsound = 'sound/weapons/rapierhit.ogg'

	var/upgraded = FALSE

	COOLDOWN_DECLARE(self_use_cooldown)

/obj/item/melee/sickly_blade/exile/upgrade/apply_fantasy_bonuses(bonus)
	bonus = abs(bonus) //Means that negative modifiers are also treated as positive.
	. = ..()

/obj/item/melee/sickly_blade/exile/upgrade/Destroy()
	current_user = null //Just in case.
	. = ..()

/obj/item/melee/sickly_blade/exile/upgrade/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	current_user = user
	START_PROCESSING(SSobj,src)

	if(!upgraded)
		var/datum/antagonist/heretic/heretic_datum = user.mind?.has_antag_datum(/datum/antagonist/heretic)
		var/is_ascended = heretic_datum?.ascended
		if(is_ascended)
			to_chat(user,span_velvet("As you touch [src], the blade glows violently, then settles down! Something seems to have changed..."))
			var/datum/component/fantasy/found_component = src.GetComponent(/datum/component/fantasy)
			if(found_component)
				qdel(found_component)
			name = "Innbury Edge"
			force = initial(force) * 2.2 //120% increased physical damage.
			attack_speed = initial(attack_speed) * (1/1.2) // 20% increased attack speed.
			src.AddElement(/datum/element/lifesteal, force * 0.02) //2% of damage leeched as life
			upgraded = TRUE
			ADD_TRAIT(src, TRAIT_INNATELY_FANTASTICAL_ITEM,EXILE_ASCENSION_TRAIT)

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
			living_target.mob_mood.set_sanity(living_target.mob_mood - round(force/4))

/obj/item/melee/sickly_blade/exile/upgrade/check_usability(mob/living/user)
	return FALSE