/datum/language/buzzwords/get_random_name(gender = NEUTER, name_count = default_name_count, syllable_min = default_name_syllable_min, syllable_max = default_name_syllable_max, force_use_syllables = FALSE)
	return "[pick(GLOB.arachnid_first)][random_name_spacer][pick(GLOB.arachnid_last)]"
