
/datum/species/teshari/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	ADD_WADDLE(C, WADDLE_SOURCE_TESHARI)

/datum/species/teshari/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	REMOVE_WADDLE(C, WADDLE_SOURCE_TESHARI)
//BUBBER EDIT ADDITION: TESHARI WADDLE
