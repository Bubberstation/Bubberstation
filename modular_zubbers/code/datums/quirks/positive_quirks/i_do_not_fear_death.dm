/datum/quirk/i_do_not_fear_death
	name = "Accepted Mortality"
	desc = "You've accepted your own mortality (or perhaps the miracles of modern healthcare), and do not suffer a mood penalty when dying."
	icon = FA_ICON_HAND_MIDDLE_FINGER
	value = 4
	mob_trait = TRAIT_I_DO_NOT_FEAR_DEATH
	gain_text = span_notice("Death is inevitable. Our fear of it makes us play safe, blocks out emotion. It's a losing game.")
	lose_text = span_danger("Wait a minute... what if I die, and there is no one competent enough to save me? Oh god.")
	medical_record_text = "Patient demonstrates a complete lack of caring on the subject of dying."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_MOODLET_BASED