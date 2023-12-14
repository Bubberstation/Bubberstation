GLOBAL_DATUM(voice_chime, /datum/voice_chime)

/datum/preference/choiced/voice_chime	//The tgui voice dropdown in char prefs
    category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
    savefile_identifier = PREFERENCE_CHARACTER
    savefile_key = "voice_chime"

//List of possible voices
/datum/preference/choiced/voice_chime/init_possible_values()
    return list("No sound","Voice 1","Voice 2")

/datum/preference/choiced/voice_chime/create_default_value()
	return "No sound"

/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
//	/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value)
//	var/voice_id
//	var/voice_id = GLOB.voice_types[value]
//    if(voice_id)
//    var/datum/voice_type = new voice_id
//  var/datum/voice_type/voice_type = new voice_id

// /datum/preference/choiced/voice_chime/apply_to_human(mob/living/living_say/target, value)
//    if(client && !HAS_TRAIT(H, TRAIT_SIGN_LANG))
//        var/sound/speak_sound
//	if(ending == "?")
//            speak_sound = voice_types[voice_type]["?"]
//       else if(ending == "!")
//           speak_sound = voice_types[voice_type]["!"]
//        else
//        speak_sound = voice_types[voice_type][voice_type]
//        playsound(src, speak_sound, 300, 1, SHORT_RANGE_SOUND_EXTRARANGE-2, falloff_exponent = 0, pressure_affected = FALSE, ignore_walls = FALSE, use_reverb = FALSE)

/datum/preference/toggle/voice_chime	//toggle on or off voices in game prefs
    category = PREFERENCE_CATEGORY_GAME_PREFERENCES
    savefile_key = "voice_chime_toggle"
    savefile_identifier = PREFERENCE_PLAYER

/client/var/voice_chime
/datum/client_interface/var/voice_chime

/datum/preference/toggle/voice_chime/apply_to_client(client/client, value)
        client.voice_chime = TRUE
        client.voice_chime = FALSE
