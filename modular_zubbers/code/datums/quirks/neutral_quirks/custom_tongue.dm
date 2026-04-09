/datum/quirk/custom_tongue
	name = "Custom Tongue"
	desc = "Your tongue is not standard. It has a shape and texture that is unique to you, affecting the way you speak."
	gain_text = span_notice("Your tongue feels normal.")
	lose_text = span_notice("Your tongue feels... Different.")
	medical_record_text = "Patient speaks a little funny."
	value = 0
	icon = FA_ICON_FACE_GRIN_TONGUE

// Parent preference for convenience. Everything that runs on this (Such as the serialize code) will apply to the remainder of our preferences.
/datum/preference/text/custom_tongue
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "custom_tongue"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 64 // We may want to lower this for sanity.

/datum/preference/text/custom_tongue/serialize(input)
	var/regex/unwanted_characters = regex(@"[^a-z]") // Prevent people from inputting slop into my text fields. No, you CAN'T have an eggplant emoji for when you whisper.
	if(unwanted_characters.Find(input))
		return null // No fun allowed.
	return htmlrendertext(input)

/datum/preference/text/custom_tongue/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Custom Tongue" in preferences.all_quirks

/datum/preference/text/custom_tongue/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/custom_tongue/ask
	savefile_key = "custom_tongue_ask"

/datum/preference/text/custom_tongue/exclaim
	savefile_key = "custom_tongue_exclaim"

/datum/preference/text/custom_tongue/whisper
	savefile_key = "custom_tongue_whisper"

/datum/preference/text/custom_tongue/yell
	savefile_key = "custom_tongue_yell"

/datum/preference/text/custom_tongue/say
	savefile_key = "custom_tongue_say"

/datum/quirk_constant_data/custom_tongue
	associated_typepath = /datum/quirk/custom_tongue
	customization_options = list(
		/datum/preference/text/custom_tongue/ask,
		/datum/preference/text/custom_tongue/exclaim,
		/datum/preference/text/custom_tongue/whisper,
		/datum/preference/text/custom_tongue/yell,
		/datum/preference/text/custom_tongue/say
	)

/// Used to set the quirk holder's say modifiers based on the client preferences. Runs on quirk add and on COMSIG_SET_SAY_MODIFIERS signal (sent in /obj/item/organ/tongue/proc/set_say_modifiers())
/datum/quirk/custom_tongue/proc/tongue_setup() // This proc will run at most three times depending on the client prefs.
	SIGNAL_HANDLER

	var/client/client_source = quirk_holder.client

	var/new_ask = client_source?.prefs.read_preference(/datum/preference/text/custom_tongue/ask)
	if (new_ask)
		quirk_holder.verb_ask = LOWER_TEXT(new_ask)

	var/new_exclaim = client_source?.prefs.read_preference(/datum/preference/text/custom_tongue/exclaim)
	if (new_exclaim)
		quirk_holder.verb_exclaim = LOWER_TEXT(new_exclaim)

	var/new_whisper = client_source?.prefs.read_preference(/datum/preference/text/custom_tongue/whisper)
	if (new_whisper)
		quirk_holder.verb_whisper = LOWER_TEXT(new_whisper)

	var/new_yell = client_source?.prefs.read_preference(/datum/preference/text/custom_tongue/yell)
	if (new_yell)
		quirk_holder.verb_yell = LOWER_TEXT(new_yell)

	var/new_say = client_source?.prefs.read_preference(/datum/preference/text/custom_tongue/say)
	if (new_say)
		var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
		tongue.say_mod = LOWER_TEXT(new_say)

	return TRUE

/datum/quirk/custom_tongue/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_SET_SAY_MODIFIERS, PROC_REF(tongue_setup))
	tongue_setup()

/datum/quirk/custom_tongue/remove(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	quirk_holder.verb_ask = initial(quirk_holder.verb_ask)
	quirk_holder.verb_exclaim = initial(quirk_holder.verb_exclaim)
	quirk_holder.verb_whisper = initial(quirk_holder.verb_whisper)
	quirk_holder.verb_yell = initial(quirk_holder.verb_yell)
	tongue.say_mod = initial(tongue.say_mod)
	UnregisterSignal(quirk_holder, COMSIG_SET_SAY_MODIFIERS)
