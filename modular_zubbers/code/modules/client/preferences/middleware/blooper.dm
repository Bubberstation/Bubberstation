/datum/preference_middleware/blooper
	action_delegations = list(
		"play_blooper" = PROC_REF(play_blooper),
	)

/datum/preference_middleware/blooper/proc/play_blooper(list/params, mob/user)
	var/datum/blooper/blooper_to_use = SSblooper.blooper_list[preferences.read_preference(/datum/preference/choiced/blooper)]
	var/blooper_speed = preferences.read_preference(/datum/preference/numeric/blooper_speed)
	var/blooper_pitch = preferences.read_preference(/datum/preference/numeric/blooper_pitch)
	var/blooper_pitch_range = preferences.read_preference(/datum/preference/numeric/blooper_pitch_range)
	blooper_to_use.play_bloop(user, list(user), "This is a test message to hear a blooper.", 7, 70, blooper_speed, blooper_pitch, blooper_pitch_range)
	return TRUE
