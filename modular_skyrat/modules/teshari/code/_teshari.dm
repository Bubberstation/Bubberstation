#define TESHARI_TEMP_OFFSET -10 // K, added to comfort/damage limit etc
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.

/datum/species/teshari
	name = "Teshari"
	id = SPECIES_TESHARI
	no_gender_shaping = TRUE // Female uniform shaping breaks Teshari worn sprites, so this is disabled. This will not affect anything else in regards to gender however.
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
	)
	digitigrade_customization = DIGITIGRADE_NEVER
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	mutanttongue = /obj/item/organ/tongue/teshari
	mutanteyes = /obj/item/organ/eyes/teshari
	custom_worn_icons = list(
		OFFSET_HEAD = TESHARI_HEAD_ICON,
		OFFSET_FACEMASK = TESHARI_MASK_ICON,
		OFFSET_NECK = TESHARI_NECK_ICON,
		OFFSET_SUIT = TESHARI_SUIT_ICON,
		OFFSET_UNIFORM = TESHARI_UNIFORM_ICON,
		OFFSET_GLOVES =  TESHARI_HANDS_ICON,
		OFFSET_SHOES = TESHARI_FEET_ICON,
		OFFSET_GLASSES = TESHARI_EYES_ICON,
		OFFSET_BELT = TESHARI_BELT_ICON,
		OFFSET_BACK = TESHARI_BACK_ICON,
		OFFSET_ACCESSORY = TESHARI_ACCESSORIES_ICON,
		OFFSET_EARS = TESHARI_EARS_ICON
	)
	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	mutantears = /obj/item/organ/ears/teshari
	mutantlungs = /obj/item/organ/lungs/adaptive/cold
	body_size_restricted = TRUE
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/teshari,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/teshari,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/teshari,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/teshari,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/teshari,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/teshari,
	)
	meat = /obj/item/food/meat/slab/chicken/human

/datum/species/teshari/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Teshari (Default)", TRUE),
		"ears" = list("Teshari Regular", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/obj/item/organ/tongue/teshari
	liked_foodtypes = SEAFOOD | VEGETABLES | NUTS
	disliked_foodtypes = GROSS | GRAIN

/obj/item/organ/eyes/teshari
	name = "teshari eyes"
	eye_icon = 'modular_skyrat/modules/organs/icons/teshari_eyes.dmi'

/datum/species/teshari/prepare_human_for_preview(mob/living/carbon/human/tesh)
	var/base_color = "#c0965f"
	var/ear_color = "#e4c49b"

	tesh.dna.features[FEATURE_MUTANT_COLOR] = base_color
	tesh.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Teshari Feathers Upright", MUTANT_INDEX_COLOR_LIST = list(ear_color, ear_color, ear_color))
	tesh.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Teshari (Default)", MUTANT_INDEX_COLOR_LIST = list(base_color, base_color, ear_color))
	regenerate_organs(tesh, src, visual_only = TRUE)
	tesh.update_body(TRUE)

/datum/species/teshari/on_species_gain(mob/living/carbon/human/new_teshari, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	passtable_on(new_teshari, SPECIES_TRAIT)

/datum/species/teshari/on_species_loss(mob/living/carbon/C, datum/species/new_species, pref_load)
	. = ..()
	passtable_off(C, SPECIES_TRAIT)

/datum/species/teshari/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_RUNNING,
		SPECIES_PERK_NAME = "Tablerunning",
		SPECIES_PERK_DESC = "A being of extreme agility, you can jump on tables just by running into them!"
	))

	return perk_descriptions

/datum/species/teshari/get_species_description()
	return list(
		"A species of birdperson hailing from the tropical planet Sirisai, their introduction \
		came in the form of the complete and utter destruction of their oppressors, now lost to the wind.",
		"They are extremely agile, owing to their low mass, but their hollow bones make them more vulnerable to being hurt."
	)

/datum/species/teshari/get_species_lore()
	return list(
		"Teshari are a bird-like species that hail from a tropical world, Sirisai. They generally are between 3'5 and 4'0 tall, \
		light avian bodies with large plumes of feathers, and vestigial wings. They tend to have muzzles, \
		but some have slowly evolved beak-like snouts as Sirisai has left its ice age. Teshari are very colorful, and they have large ears for hearing. \
		Teshari tend to live to 60-70 before dying of natural causes, though medical care can extend this significantly. \
		Teshari are omnivores that love fish, and dislike grain. They prefer nuts and vegetation.",
		"Teshari have a genetic need for socialization and will feel physically ill if not social at all for an extended period, \
		which has caused them to form social groups called flocks. Teshari generally lack parental figures, and are often \
		raised communally. When they reach adulthood, they feel a strong drive to move away from their nesting flock and find or develop a new one. \
		Teshari tend to be cloistered and quiet when entering a new social space, but are very vocal and impassioned when they fit in, often enjoying making and parroting noises.",
		"Sirisai is a tropical world with temperatures ranging from 20 to 30 celsius on average. \
		It has three notable mountain ranges, the only places on the planet where snow can still be seen year-round. Temperatures can go as low as -15 Celsius. \
		The planet itself is generally very biologically diverse, ecologically pure compared to many inhabited planets.",
		"Modern Teshari history began when they were discovered and uplifted by a species that resided on the planet Sirisai once orbited. \
		After years of oppression and being sold as a labor force, the Teshari made their demand: Comply, or explode. This species seemed to not have taken the threat seriously, \
		and were made extinct by the destruction of their entire planet. Fossils have been uncovered on Sirisai, and while they have yet to be named, \
		A meeting of Teshari flocks have democratically named the species after the Teshari word for \"bastard\". \
		Needless to say, this very quickly led to the normalization of relations and formal recognition by the then NRI.",
	)
