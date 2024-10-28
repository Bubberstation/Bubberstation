// UNIMPLEMENTED QUIRK!
/datum/quirk/pharmacokinetics
	name = "Acute Hepatic Pharmacokinetics"
	desc = "You have a genetic disorder that causes Incubus Draft and Succubus Milk to be absorbed by your liver instead."
	value = 0
	gain_text = span_purple("Your body has adapted to process growth chemicals.")
	lose_text = span_purple("Your liver no longer protects you from strange chemicals.")
	medical_record_text = "Patient's liver has adapted to filter out exotic growth chemicals."
	mob_trait = TRAIT_PHARMA
	icon = FA_ICON_FILE_MEDICAL

	// Copy pasted from old code
	/*
	var/active = FALSE
	var/power = 0
	var/cachedmoveCalc = 1
	*/
