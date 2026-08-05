// we let borgs have some bark too
/mob/living/silicon/Login()
	blooper = SSblooper.blooper_list[client.prefs.read_preference(/datum/preference/choiced/blooper)]
	blooper_speed = client.prefs.read_preference(/datum/preference/numeric/blooper_speed)
	blooper_pitch = client.prefs.read_preference(/datum/preference/numeric/blooper_pitch)
	blooper_pitch_range = client.prefs.read_preference(/datum/preference/numeric/blooper_pitch_range)
	. = ..()
