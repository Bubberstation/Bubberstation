/mob/living/carbon/human/proc/adjust_pleasure(pleas = 0, mob/living/carbon/human/partner, datum/interaction/interaction, position)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	pleasure = clamp(pleasure + pleas, AROUSAL_MINIMUM, AROUSAL_LIMIT * (dna.features["lust_tolerance"] || 1)) // SPLURT EDIT - Lust tolerance

	if(pleasure >= AROUSAL_AUTO_CLIMAX_THRESHOLD * (dna.features["lust_tolerance"] || 1)) // lets cum // SPLURT EDIT - Lust tolerance
		climax(manual = FALSE, partner = partner, climax_interaction = interaction, interaction_position = position)
