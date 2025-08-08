
/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	normalize_organs()


/datum/species/jelly/get_species_description()
	return list(
		"Slimepeople are the product of many years of xenobiological experimentation,\
		Their bodies are simple yet fluid, and resemble single-celled organisms. They are composed of slime jelly.\
		They struggle in cold environments, and things that are normally toxic to living species heal them."
	)

/datum/species/jelly/get_species_lore()
	return list(
		"A species essentially crafted whole-cloth by Nanotrasen's R&D department in Sector C7,\
		slimepeople were produced by uplifting xenobiological slimes made in a laboratory environment.",

		"Their bodies are malleable, and structurally resemble a cell, with simple organs in the center of their bodies.\
		They have no defined appearance, but struggle to fully pass as other species.\
		They have since spread out in small numbers all over the universe, but the majority remain in the company's orbit.",

		"Slimepeople have developed a beautiful system of body language, typically involving light and the fluidity of their bodies in elaborate dances and gestures.\
		Due to their chemical makeup, they are able to produce bioluminescent lighting within their membrane.\
		It has been documented that a person can be 'melted' into a slimeperson much like with non-sentient, xenobiological slimes.\
		It has little effect on sapience, and as a result, a few researchers in Nanotrasen R&D have transformed themselves this way.",
	)
