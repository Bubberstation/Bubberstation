/datum/heretic_knowledge/spell/paranoias_eye
	name = "Paranoia's Eye"
	desc = "Forces nearby heathens to hallucinate everyone around them as a dangerous heretic, including you. Completely obscures identities. Lasts for one minute. (Can be casted without a focus)"
	gain_text = "The blinding light of The Open Way blinds them. It would blind me, if not for my own resolve."
	drafting_tier = 1
	action_to_add = /datum/action/cooldown/spell/paranoias_eye

/datum/action/cooldown/spell/paranoias_eye
	name = "Paranoia's Eye"
	desc = "Forces nearby heathens to hallucinate everyone around them as a dangerous heretic, including you. Has a long range and penetrates walls. Lasts for one minute. (Can be casted without a focus)"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "gaze"
	cooldown_time = 2 MINUTES

	sound = null
	school = SCHOOL_EVOCATION
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND
	invocation_type = INVOCATION_NONE // sneaky spell
	spell_requirements = NONE
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	focusless_inhibitable = TRUE

/datum/action/cooldown/spell/paranoias_eye/cast(atom/cast_on)
	. = ..()

	for (var/mob/living/iter_living in get_hearers_in_range(20, owner)) // large range
		if (IS_HERETIC_OR_MONSTER(iter_living))
			continue
		if (iter_living.can_block_magic(antimagic_flags))
			to_chat(iter_living, span_warning("You shiver as you sense an eldritch incursion bounce off your mind."))
			iter_living.emote("shiver")
			continue
		iter_living.cause_hallucination(/datum/hallucination/delusion/paranoias_eye, "Heretic Hallucination Spell", duration = 1 MINUTES)
		iter_living.adjust_eye_blur_up_to(20 SECONDS, 30 SECONDS)
		to_chat(iter_living, span_hypnophrase("LIGHT BLEEDS THROUGH THE CRACK IN THE GATE. I AM BLINDED - SOUL AND BODY."))
	to_chat(owner, span_warning("You make the subtle kinetoglyph. The way is now open."))

/datum/hallucination/delusion/paranoias_eye
	dynamic_delusion = TRUE
	random_hallucination_weight = 0
	affects_others = TRUE
	affects_us = FALSE
	delusion_name = "THE LIGHT BLINDS YOU."

/datum/hallucination/delusion/paranoias_eye/make_delusion_image(mob/over_who)
	delusion_appearance = get_dynamic_human_appearance(
		outfit_path = /datum/outfit/heretic_hallucination,
		species_path = /datum/species/skeleton,
		bloody_slots = ALL,
	)
	return ..()

/datum/hallucination/delusion/paranoias_eye/start()
	. = ..()

	ADD_TRAIT(hallucinator, TRAIT_BLOCK_SECHUD, REF(src))
	ADD_TRAIT(hallucinator, TRAIT_PARANOIAS_EYE, REF(src))

/datum/hallucination/delusion/paranoias_eye/Destroy()
	REMOVE_TRAIT(hallucinator, TRAIT_PARANOIAS_EYE, REF(src))
	REMOVE_TRAIT(hallucinator, TRAIT_BLOCK_SECHUD, REF(src))
	return ..()
