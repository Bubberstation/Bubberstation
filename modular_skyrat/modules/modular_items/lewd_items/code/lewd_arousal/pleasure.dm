/mob/living/carbon/human/proc/adjust_pleasure(pleas = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	pleasure = clamp(pleasure + pleas, AROUSAL_MINIMUM, AROUSAL_LIMIT)

	if(pleasure >= AROUSAL_AUTO_CLIMAX_THRESHOLD) // lets cum
		climax(manual = FALSE)
