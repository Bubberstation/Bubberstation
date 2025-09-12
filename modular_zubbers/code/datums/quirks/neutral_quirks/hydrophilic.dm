/datum/quirk/hydrophilic
	name = "Hydrophilic"
	desc = "(Slimeperson only) Your molecules are highly hydrophilic - or, in layman's terms, dissolve very well in water. You should probably stay away from it..."
	icon = FA_ICON_BUG // I can't be asked to make an icon for this, my spritework sucks.
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("You get the feeling you should stay away from water...")
	lose_text = span_notice("Somehow, you feel as if water is no longer dangerous.")
	medical_record_text = "Patient scans indicate extreme hydrophilicity."
	hardcore_value = 0
	mob_trait = TRAIT_HYDROPHILIC
	species_whitelist = list(SPECIES_SLIMESTART)
