/datum/quirk/hydrophilic
	name = "Hydrophilic"
	desc = "(Slimeperson only) Your molecules are highly hydrophilic - or, in layman's terms, dissolve very well in water. You should probably stay away from it..."
	icon = FA_ICON_BUG // I can't be asked to make an icon for this, my spritework sucks.
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY
	quirk_whitelist_flags = QUIRK_SLIMEPERSON_ONLY
	gain_text = "<span class='danger'>You get the feeling you should stay away from water...</span>"
	lose_text = "<span class='notice'>Somehow, you feel as if water is no longer dangerous.</span>"
	medical_record_text = "Patient scans indicate extreme hydrophilicity."
	hardcore_value = 0
	mob_trait = TRAIT_HYDROPHILIC
