/datum/preference/choiced/voice_chime
    category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
    savefile_identifier = PREFERENCE_CHARACTER
    savefile_key = "voice_chime"

/datum/preference/choiced/voice_chime/init_possible_values()
    return assoc_to_keys(GLOB.voice_types)

/datum/preference/choiced/voice_chime/apply_to_human(mob/living/carbon/human/target, value)
var/voice_id = GLOB.voice_types[value]
    if(voice_id)
//		var/datum/voice_type = new voice_id
    var/datum/voice_type/voice_type = new voice_id
    target.voice_chime = voice_type

/datum/preference/choiced/voice_chime/apply_to_human(mob/living/living_say/target, value)
var/voice_type = GLOB.voice_types[value]
    if(client && !HAS_TRAIT(H, TRAIT_SIGN_LANG))
        var/ending = copytext_char(message, -1)
        var/sound/speak_sound
        if(ending == "?")
            speak_sound = voice_types[voice_type]["?"]
        else if(ending == "!")
            speak_sound = voice_types[voice_type]["!"]
        else
            speak_sound = voice_types[voice_type][voice_type]
        playsound(src, speak_sound, 300, 1, SHORT_RANGE_SOUND_EXTRARANGE-2, falloff_exponent = 0, pressure_affected = FALSE, ignore_walls = FALSE, use_reverb = FALSE)
