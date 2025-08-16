/datum/species/pod
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_PLANT_SAFE,
		TRAIT_LITERATE,
	)
	mutant_bodyparts = list()
	payday_modifier = 1.0

/datum/species/pod/get_default_mutant_bodyparts()
	return list(
		"pod_hair" = list("Ivy", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/pod/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.mutant_bodyparts["pod_hair"] = list(MUTANT_INDEX_NAME = "Ivy", MUTANT_INDEX_COLOR_LIST = list(COLOR_VIBRANT_LIME, COLOR_VIBRANT_LIME, COLOR_VIBRANT_LIME))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)

/datum/species/pod
	inert_mutation = /datum/mutation/harmonizing_pulses

/datum/species/pod/get_species_description()
	return list(
	"Aeons ago, the precursor podpeople stood alone among the sea of stars. They resolved to spread the seeds of life \
	that would ultimately survive them. Disease forced the last remnants into scarce few seedvaults, sequestered away. \
	Genetic reconstruction has revived this species from bone and dust, growing new life from replica pods designed to simulate the genesis of Podpeople.",

	"Their complex biology is benign to medical scanners, and they heal in starlight, at the cost of being more susceptible to heat and burns.",
	)

/datum/species/pod/get_species_lore()
	return list(
		"Podpeople (known as Sylvans to their own) are a species of plant person deeply connected to nature. \
		Their hair is generally vibrant, made of vines and brambles, and Podpeople generally take great joy in styling it. \
		Podpeople generally grow at a similar rate and size to humans, though their hair tends to grow facing the most common \
		direction of the sun in the system in which they reside, sometimes growing fruits and other plants when light is plentiful.",

		"Podpeople are often characterized as curious and outgoing, yet sheltered. The scale of the universe can be overwhelming to them. \
		Podpeople that exist outside of the seed vaults tend to excel at intellectual pursuits, like archaeology, research, and hydroponics. \
		They have recently become more prevalent in Sector C7 due to recently discovered evidence of Sylvan development on Indecipheres. \
		Podpeople tend to live for two to three centuries, so the extended contracts offered by Nanotrasen are less daunting.",

		"Podpeople were one of the first species in the life of the universe to spring into existence \
		when planets were more tightly packed together and the universe was warmer. Their home planet is suspected to have been unusually verdant, \
		which the Sylvans seemed to have a symbiotic relationship with. It has been described in detail, but its location remains elusive. \
		True Sylvans encountered by xenoarchaeologists have thus far tended to die of disease months after being exposed to outside life.",

		"At some point in their life cycle, Podpeople were shown to be capable of some form of short-range space travel, spreading their progeny through the stars. \
		Their technological advancements were apparently few, at least compared to contemporary examples, and no Podperson vessels have been uncovered to date. \
		Recovered documentation and oral history suggest that the Podpeople feared diseases that would prey on their apparent lack of genetic diversity.",

		"There are records of podperson vaults across the universe, typically containing one or two operators, \
		though the largest by far has recently been discovered on the surface of Indecipheres, \
		Suggesting a connection between the Podpeople and the living nature of the asteroid. Research is currently ongoing.",
	)

//Reformed podpeople, a lesser version of the species playable on-station.
/datum/species/pod/podweak
	name = "Podperson"
	id = SPECIES_PODPERSON_WEAK
	examine_limb_id = SPECIES_PODPERSON
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)

	always_customizable = FALSE

/datum/species/pod/podweak/spec_life(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(H.stat != CONSCIOUS)
		return

	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		H.adjust_nutrition(5 * light_amount * seconds_per_tick)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(0.2 * seconds_per_tick, 0.2 * seconds_per_tick, 0)
			H.adjustStaminaLoss(-0.2 * seconds_per_tick)
			H.adjustToxLoss(-0.2 * seconds_per_tick)
			H.adjustOxyLoss(-0.2 * seconds_per_tick)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(1 * seconds_per_tick, 0)
