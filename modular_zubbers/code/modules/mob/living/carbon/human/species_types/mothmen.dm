/datum/species/moth
	mutant_bodyparts = list()
	inherent_traits = list(
		TRAIT_TACKLING_WINGED_ATTACKER,
		TRAIT_ANTENNAE,
		TRAIT_MUTANT_COLORS,
	)

/datum/species/moth/get_default_mutant_bodyparts()
	return list(
		"fluff" = list("Plain", FALSE),
		"wings" = list("Moth (Plain)", TRUE),
		"moth_antennae" = list("Plain", TRUE),
	)

/datum/species/moth/randomize_features()
	var/list/features = ..()
	features["mcolor"] = "#E5CD99"
	return features

/datum/species/moth/get_random_body_markings(list/passed_features)
	var/name = SPRITE_ACCESSORY_NONE
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/moth/prepare_human_for_preview(mob/living/carbon/human/moth)
	moth.dna.features["mcolor"] = "#E5CD99"
	moth.dna.mutant_bodyparts["moth_antennae"] = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["moth_markings"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["wings"] = list(MUTANT_INDEX_NAME = "Moth (Plain)", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	regenerate_organs(moth, src, visual_only = TRUE)
	moth.update_body(TRUE)

/datum/species/moth/get_species_description()
	return list(
	"Seeking a homeworld lost long ago, the nomadic mothpeople circle the stars, led by the flagship Va Lumla. \
	They have precious, fragile wings that allow them to fly in lower pressure environments, \
	and can eat clothes for temporary nourishment. Their eyes are acutely sensitive to light.",
	"They have a strong tight-knit culture of self-reliance and community, and often easily fit in with other species. \
	A mothic captain can be sure to staunchly support his crew, and be the last one out in a crisis.",
	)

/datum/species/moth/get_species_lore()
	return list(
		"Moths are most commonly described as \"friend shaped\" due to their strong sense of community and ability to integrate well into other cultures. \
		Young moths are commonly expected to strike out in their relatively short lifespan, averaging between 70 and 100 years old, \
		when the rigors of fleet life weigh on their desire for freedom, returning later in life with new experiences and knowledge for the fleet, though some never return.",
		"Moths generally receive a universal basic income, and can struggle to understand money as they get accustomed to life outside, often spending impulsively on luxuries \
		like jewelry and clothes the moment they are given some measure of agency. \
		Moths tend to be very expressive with their body language, using the beating of their wings, clicking of their mandibles and chitters in normal conversation for emphasis. They often gravitate towards spaces that can feed their insatiable desire to novelty, which is why so many moths are seen in Sector C7 today.",
		"Life on the mothic fleet is rugged and scrappy-- every moth is expected to do their part, often having to take on extra work in order to make ends meet, especially with little ones. It is regimented, with the needs of the community outweighing the needs of the few, and ration cards can be held back for those refusing to contribute adequately to the whole. Every moth must undergo some form of military training and civil service at sixteen, after which they are free to remain or leave as they see fit. Many young moths see the end of their civil duty as an exciting time, as it often means being set loose into the wide sea of stars. There is often a wide variety of options in terms of places to go, as the Mothic fleet never stays in one place for long.",
		"At some unknown point in the past, the Mothpeople lost their homeworld, the only remains of it being a field of debris \
		that has created an assteroid belt in their home system. What started as a mostly improvised fleet of merchant ships, frigates, destroyers and cruisers \
		has developed early through piracy and shrewd diplomacy to become a nucleic fleet that floats across the stars in search of a new home for its people, \
		able to support its neutrality with force if necessary. It would still prefer to never need to consider such in the first place. \
		In the few cases where the Mothic fleet has engaged in combat or piracy in the modern day, it has been mainly due to necessity, and casualties have been minimal. \
		They are known to escort and tug damaged ships to port.",
	)
