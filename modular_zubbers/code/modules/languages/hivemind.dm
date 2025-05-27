/datum/language_holder/xeno_hybrid
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/xenocommon = list(LANGUAGE_ATOM),
		/datum/language/xenocommon/lesser_hivemind = list(LANGUAGE_ATOM),
		)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/xenocommon = list(LANGUAGE_ATOM),
		/datum/language/xenocommon/lesser_hivemind = list(LANGUAGE_ATOM),
		)

/obj/item/organ/tongue/xeno_hybrid
		modifies_speech = TRUE
		languages_native = list(/datum/language/xenocommon/lesser_hivemind)

/datum/language/xenocommon/lesser_hivemind // Parent in \code\modules\language\xenocommon.dm
	name = "Lesser Hivemind"
	desc = "The method with which Xenomorph Hybrids are able to communicate soundlessly over great distances is still ill-understood; \
			whether it be via pheromones, some kind of organic radio or even just telepathy, the reality is, it just works."
	key = "5"
	icon_state = "xeno"

/obj/item/organ/tongue/xeno_hybrid/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native) // Speaking a native language?
		return modify_speech(source, speech_args)

/obj/item/organ/tongue/xeno_hybrid/modify_speech(datum/source, list/speech_args)
	ASYNC
		actually_modify_speech(source, speech_args)
	speech_args[SPEECH_MESSAGE] = "" // Makes it not send to chat verbally.

/obj/item/organ/tongue/xeno_hybrid/proc/actually_modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	user.balloon_alert_to_viewers("Looks distracted...", "Concentrating...")

	if(!do_after(source, 2 SECONDS, source))
		message = full_capitalize(rot13(message))
	var/rendered = span_alien("<b>[user.real_name]:</b> [message]")

	user.log_talk(message, LOG_SAY, tag="xeno")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/brain/xeno_hybrid/brain = living_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!istype(brain))
			continue
		to_chat(living_mob, rendered)
		if(living_mob != user)
			living_mob.balloon_alert_to_viewers("Looks distracted...", "A voice murmurs in your head...")

	if(length(GLOB.dead_mob_list))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			if(dead_mob.client)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")
