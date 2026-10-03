/mob/living/carbon/human/get_alt_name()
	if(name != get_voice())
		return " (as [get_id_name("Unknown")])"
