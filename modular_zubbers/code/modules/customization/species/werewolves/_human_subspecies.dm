/datum/species/human/werewolf
	name = "\improper Werehuman"
	id = SPECIES_WEREHUMAN
	inherent_traits = list(
		TRAIT_WEREWOLF,
	)
	damage_modifier = list(
		BRUTE = 1.25,
		BURN = 1.25,
	)
	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/werewolf

/datum/species/human/werewolf/get_species_description()
	return "Humans are the dominant species in the known galaxy. \
		Their kind extend from old Earth to the edges of known space."

/datum/species/human/werewolf/get_species_lore()
	return list(
		"These primate-descended creatures, originating from the mostly harmless Earth, \
		have long-since outgrown their home and semi-benign designation. \
		The space age has taken humans out of their solar system and into the galaxy-at-large.",

		"In traditional human fashion, this near-record pace from terra firma to the final frontier spat \
		in the face of other races they now shared a stage with. \
		This included the lizards - if anyone was offended by these upstarts, it was certainly lizardkind.",

		"Humanity never managed to find the kind of peace to fully unite under one banner like other species. \
		The pencil and paper pushing of the UN bureaucrat lives on in the mosaic that is TerraGov; \
		a composite of the nation-states that still live on in human society.",

		"The human spirit of opportunity and enterprise continues on in its peak form: \
		the hypercorporation. Acting outside of TerraGov's influence, literally and figuratively, \
		hypercorporations buy the senate votes they need and establish territory far past the Earth Government's reach. \
		In hypercorporation territory company policy is law, giving new meaning to \"employee termination\".",
	)

/datum/species/human/werewolf/create_pref_unique_perks()

/mob/living/carbon/human/species/werehuman
	race = /datum/species/human/werewolf
