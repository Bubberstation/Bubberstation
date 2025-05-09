/datum/quirk/overweight
	name = "Overweight"
	desc = "You weigh more than an average person of your size. Being fat from food still bothers you."
	gain_text = span_notice("Your body feels heavy.")
	lose_text = span_notice("Your suddenly feel lighter!")
	value = -4
	icon = FA_ICON_BOWL_RICE
	medical_record_text = "Patient weighs higher than average."
	mob_trait = null

/datum/quirk/obese
	name = "Obese"
	desc = "You weigh much much more than the average person of your size, and are always fat no matter what. Being fat from food no longer bothers you."
	gain_text = span_notice("Your body feels <b>very</b> heavy.")
	lose_text = span_notice("Your suddenly feel much lighter!")
	value = -6
	icon = FA_ICON_HAMBURGER
	medical_record_text = "Patient is considered obese by 101% of medical textbooks, with a 1% margin of error."
	mob_trait = TRAIT_FAT
