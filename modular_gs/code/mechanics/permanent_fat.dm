/mob/living/carbon/human/become_uncliented()
	if (isnull(canon_client))
		return ..()
	
	if (isnull(canon_client.prefs))
		return ..()

	// we know we have a client and they have prefs
	if (canon_client.prefs.read_preference(/datum/preference/toggle/weight_gain_persistent))
		canon_client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/starting_fatness], fatness_real)

	canon_client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/perma_fat_value], fatness_perma)

	. = ..()
