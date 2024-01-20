/datum/species/teshari/alt
	name = "Teshari" // My beloved <3
	id = SPECIES_TESHARI_ALT
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_HAS_MARKINGS,
		TRAIT_WEAK_BODY,
		TRAIT_CAN_BE_PICKED_UP
	)
	coldmod = TESHARI_ALT_COLDMOD
	heatmod = TESHARI_ALT_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_ALT_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_ALT_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_ALT_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	body_size_restricted = TRUE

	var/datum/action/cooldown/raptor/echolocation/raptor_echolocation
	var/datum/action/cooldown/raptor/agility/raptor_agility

/datum/species/teshari/alt/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	raptor_echolocation = new()
	raptor_echolocation.Grant(human_who_gained_species)
	raptor_agility = new()
	raptor_agility.Grant(human_who_gained_species)

/datum/species/teshari/alt/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	qdel(raptor_echolocation)
	qdel(raptor_agility)

/datum/species/teshari/alt/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Extremely weak body",
		SPECIES_PERK_DESC = "Raptor body is extemely weak. They take A LOT OF DAMAGE from everything."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Frailty",
		SPECIES_PERK_DESC = "The raptor are weak. They cannot use heavy weapons, or carry larger loads without special equipment. Neither can they pull other bodies on top of them."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Extreme heat weakness",
		SPECIES_PERK_DESC = "Raptor are extremely unstable to heat..."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Pure robust",
		SPECIES_PERK_DESC = "Raptor can't push creatures bigger than them. Nor can they fight properly."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Smol",
		SPECIES_PERK_DESC = "Raptor is smol. Other creatures can pick them up."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Robust cold protect",
		SPECIES_PERK_DESC = "Raptor are incredibly resistant to low temperatures."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Agility",
		SPECIES_PERK_DESC = "Raptor are incredibly maneuverable, easily able to climb on tables. They are also faster than most other creatures."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-plus",
		SPECIES_PERK_NAME = "Clear hearing",
		SPECIES_PERK_DESC = "Raptro - have clear hearing, allowing them to hear creatures around them, pinpointing locations."
	))
	return perk_descriptions

/datum/species/human/get_species_description()
	return "A race of feathered, upright space raptors that have incredibly good. \
		hearing and have good thermal insulation, giving them good \
		defense against low temperatures. But because of their biology, \
		they have extremely fragile bodies that are vulnerable to high temperatures and fire."
