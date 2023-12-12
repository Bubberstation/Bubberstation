    //This middleware is to preview the voice chime on the character menu.
	//But I don't know how to make it work without errors so I commented everything

///datum/preference_middleware/voice_preview
 //   COOLDOWN_DECLARE(voice_test_cooldown)

//        action_delegations = list(
//        "play_voice" = PROC_REF(play_voice),
//    )

///datum/preference_middleware/voice_preview/proc/play_voice(list/params, mob/user)
//    if(!COOLDOWN_FINISHED(src, voice_test_cooldown))
//return TRUE

//var/speaker = preferences.read_preference(/datum/preference/choiced/voice_chime)
//    COOLDOWN_START(src, voice_test_cooldown, 0.5 SECONDS)
//    INVOKE_ASYNC(TYPE_PROC_REF(/datum/voice_type), speaker = speaker, local = TRUE)
//return TRUE
