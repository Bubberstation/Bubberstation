/datum/preference/toggle/disable_dizzyness
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "disable_dizziness"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/datum/status_effect/dizziness/on_creation(mob/living/new_owner, duration)
	if(new_owner && new_owner.client?.prefs?.read_preference(/datum/preference/toggle/disable_dizzyness))
		new_owner.adjust_eye_blur(duration)
		return FALSE
	. = ..()
