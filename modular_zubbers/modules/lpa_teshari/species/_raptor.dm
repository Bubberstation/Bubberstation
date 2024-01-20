/**
 * Overriding original teshari
 */
/datum/species/teshari
	name = "Raptor"
	coldmod = RAPTOR_COLDMOD
	heatmod = RAPTOR_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + RAPTOR_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + RAPTOR_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + RAPTOR_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/human_basic
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/raptor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/raptor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/raptor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/raptor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/raptor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/raptor,
	)


/datum/species/teshari/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	human_who_gained_species.mob_size = MOB_SIZE_SMALL
	human_who_gained_species.physiology.hunger_mod *= RAPTOR_HUNGERMOD

/datum/species/teshari/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.physiology.hunger_mod = initial(C.physiology.hunger_mod)
	C.mob_size = initial(C.mob_size)

/datum/species/teshari/randomize_features(mob/living/carbon/human/human_mob)
	. = ..()
	if(!human_mob)
		return
	var/main_color = pick(COLOR_GRAY, COLOR_DARK_BROWN, COLOR_ALMOST_BLACK, COLOR_DARK_RED, COLOR_DARK_CYAN)
	var/second_color = pick(COLOR_WHITE, COLOR_BLACK, COLOR_BLUE, COLOR_VIOLET)
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = second_color
	human_mob.dna.features["mcolor3"] = second_color

/datum/species/teshari/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Extremely weak body",
		SPECIES_PERK_DESC = "Raptor body is extemely weak. They take A LOT OF DAMAGE from everything."
	))

	return perk_descriptions
