/datum/language/marish
	name = "Marish"
	desc = "Where shadekin have a language rooted in empathy, there are still subtle tones and syllables that are as delicate as the emotions that shadekin normally communicate with."
	key = "M"
	space_chance = 55
	icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
	icon_state = "canilunzt"
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
/obj/item/organ/internal/tongue/shadekin
	name = "shadekin tongue"
	desc = "A mysterious tongue."
	icon_state = "silvertongue"
	say_mod = "mars"
	sense_of_taste = TRUE
	modifies_speech = TRUE
	languages_native = list(/datum/language/marish/empathy)

/datum/language/marish/empathy
	name = "Empathy"
	desc = "Shadekin seem to always know what the others are thinking. This is probably why."
	key = "9"



/obj/item/organ/internal/tongue/shadekin/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native) // Speaking a native language?
		return modify_speech(source, speech_args)



/obj/item/organ/internal/tongue/shadekin/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")
	user.log_talk(message, LOG_SAY, tag="shadekin")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/internal/tongue/shadekin/tongue = living_mob.get_organ_slot(ORGAN_SLOT_TONGUE)
		if(!istype(tongue))
			continue
		to_chat(living_mob, rendered)

	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, user)
		to_chat(dead_mob, "[link] [rendered]")

	speech_args[SPEECH_MESSAGE] = ""
