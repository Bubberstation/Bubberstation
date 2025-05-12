/datum/species/ethereal/get_species_description()
	return list("Coming from the planet of Sprout, the theocratic ethereals are \
		separated socially by caste, and espouse a dogma of aiding the weak and \
		downtrodden.",)

/datum/species/ethereal/on_species_gain(mob/living/carbon/human/new_ethereal, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/datum/action/sing_tones/sing_action = new
	sing_action.Grant(new_ethereal)
