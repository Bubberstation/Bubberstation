/datum/language/marish
	name = "Marish"
	desc = "Where shadekin have a language rooted in empathy, there are still subtle tones and syllables that are as delicate as the emotions that shadekin normally communicate with."
	key = "M"
	space_chance = 55
	icon = 'modular_zubbers/icons/misc/language.dmi'
	icon_state = "marish"
	default_priority = 90
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | NO_STUTTER
	syllables = list("mar", "mwrrr", "maaAr", "'aarrr", "wrurrl", "mmar")

/datum/language_holder/shadekin
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/marish = list(LANGUAGE_ATOM),
								/datum/language/marish/empathy = list(LANGUAGE_ATOM),
								)
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/marish = list(LANGUAGE_ATOM),
							/datum/language/marish/empathy = list(LANGUAGE_ATOM),
							)
/obj/item/organ/tongue/shadekin
	name = "shadekin tongue"
	desc = "A mysterious tongue."
	icon_state = "silvertongue"
	say_mod = "mars"
	sense_of_taste = TRUE
	modifies_speech = TRUE
	languages_native = list(/datum/language/marish/empathy)

/obj/item/organ/ears/shadekin
	name = "shadekin ears"
	desc = "Ears, covered in fur."
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	damage_multiplier = 2.5 // Shadekins big ears are easy to damage with loud noises.
	overrides_sprite_datum_organ_type = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/datum/language/marish/empathy
	name = "Empathy"
	desc = "Shadekin seem to always know what the others are thinking. This is probably why."
	key = "9"
	icon_state = "empathy"

/obj/item/organ/tongue/shadekin/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native) // Speaking a native language?
		return modify_speech(source, speech_args)

/obj/item/organ/tongue/shadekin/modify_speech(datum/source, list/speech_args)
	ASYNC
		actually_modify_speech(source, speech_args)
	speech_args[SPEECH_MESSAGE] = "" // Makes it not send to chat verbally.

/obj/item/organ/tongue/shadekin/proc/actually_modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/obj/item/organ/ears/shadekin/user_ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	var/mode = istype(user_ears)
	user.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "projecting thoughts...")

	if(!do_after(source, 2 SECONDS, source))
		message = full_capitalize(rot13(message))
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")

	user.log_talk(message, LOG_SAY, tag="shadekin")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/ears/shadekin/target_ears = living_mob.get_organ_slot(ORGAN_SLOT_EARS)

		if(!istype(target_ears))
			continue

		to_chat(living_mob, rendered)
		if(living_mob != user)
			mode = istype(target_ears)
			living_mob.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "transmission heard...")

	if(length(GLOB.dead_mob_list))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			if(dead_mob.client)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")

