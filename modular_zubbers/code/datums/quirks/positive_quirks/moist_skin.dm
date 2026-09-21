/datum/quirk/moist_skin
	name = "Mucus Lining" // Lizard, Still unsure of the name. Might change later.
	desc = "Through whatever means, your skin produces a thin layer of protective mucus that causes you to feel wet to the touch. Surprisingly helpful when it comes to fires! "
	icon = FA_ICON_DOVE // Lizard, To do.
	quirk_flags = QUIRK_HUMAN_ONLY
	value = 2
	mob_trait = TRAIT_MOIST_SKIN
	gain_text = span_danger("You feel wet.")
	lose_text = span_notice("You suddenly feel dry.")
	medical_record_text = "TBD"
