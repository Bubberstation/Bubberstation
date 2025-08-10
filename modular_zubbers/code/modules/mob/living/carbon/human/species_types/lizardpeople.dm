
/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/lizard/get_species_description()
	return list("The militaristic Lizardpeople hail originally from Tizira, but have grown \
		throughout their centuries in the stars to possess a large spacefaring \
		empire: though now they must contend with their younger, more \
		technologically advanced Human neighbours.",)

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#FFA756")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.features["mcolor2"] = "#DE893A"
	lizard.dna.features["mcolor3"] = "#DE893A"
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Drake", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Neck Frills (New)", MUTANT_INDEX_COLOR_LIST = list(lizard_color, "#DE893A", "#DE893A"))
	lizard.dna.features["legs"] = "Normal Legs"
	lizard.set_facial_hairstyle("Lizard Tongue Flick")
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)
