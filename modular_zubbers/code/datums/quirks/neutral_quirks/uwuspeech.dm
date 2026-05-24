/datum/quirk/uwu_speech
	name = "Uwu Speech"
	desc = "You have an irresistibly cutesy speech pattern."
	icon = FA_ICON_RAINBOW
	value = 0
	mob_trait = TRAIT_UWU_SPEECH
	gain_text = span_notice(You feel a lot more cute and expressive.)
	lose_text = span_notice(You feel your speech returning to normal.)
	medical_record_text = "Patient displays a persistent cutesy speech pattern."

/datum/quirk/uwu_speech/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/quirk/uwu_speech/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_SAY)
	return ..()

/datum/quirk/uwu_speech/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	if(!message)
		return

	message = replacetext(message, "r", "w")
	message = replacetext(message, "l", "w")
	message = replacetext(message, "R", "W")
	message = replacetext(message, "L", "W")

	message = replacetext(message, "na", "nya")
	message = replacetext(message, "ne", "nye")
	message = replacetext(message, "ni", "nyi")
	message = replacetext(message, "no", "nyo")
	message = replacetext(message, "nu", "nyu")

	message = replacetext(message, "Na", "Nya")
	message = replacetext(message, "Ne", "Nye")
	message = replacetext(message, "Ni", "Nyi")
	message = replacetext(message, "No", "Nyo")
	message = replacetext(message, "Nu", "Nyu")

	speech_args[SPEECH_MESSAGE] = message
