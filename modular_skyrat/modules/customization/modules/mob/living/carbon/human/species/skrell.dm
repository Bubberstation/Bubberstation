/datum/species/skrell
	name = "Skrell"
	id = SPECIES_SKRELL
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		NO_SLIP_WHEN_WALKING
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_HARDLY_WOUNDED,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	brutemod = 1.70
	burnmod = 0.60
	exotic_blood = /datum/reagent/copper
	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 30)
	species_language_holder = /datum/language_holder/skrell
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/skrell
	toxic_food = DAIRY
	disliked_food = RAW | CLOTH
	liked_food = TOXIC | FRUIT | VEGETABLES | SEAFOOD
	payday_modifier = 0.75
	default_mutant_bodyparts = list("skrell_hair" = ACC_RANDOM)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	eyes_icon = 'modular_skyrat/modules/organs/icons/skrell_eyes.dmi'
	mutantbrain = /obj/item/organ/internal/brain/skrell
	mutanteyes = /obj/item/organ/internal/eyes/skrell
	mutantlungs = /obj/item/organ/internal/lungs/skrell
	mutantheart = /obj/item/organ/internal/heart/skrell
	mutantliver = /obj/item/organ/internal/liver/skrell
	mutanttongue = /obj/item/organ/internal/tongue/skrell
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/skrell,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/skrell,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/skrell,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/skrell,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/skrell,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/skrell,
	)

/datum/species/skrell/get_species_description()
	return placeholder_description

/datum/species/skrell/get_species_lore()
	return list(placeholder_lore)

/datum/species/skrell/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/random = rand(1,6)
	//Choose from a range of green-blue colors
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#22FF88"
		if(3)
			main_color = "#22FFBB"
		if(4)
			main_color = "#22FFFF"
		if(5)
			main_color = "#22BBFF"
		if(6)
			main_color = "#2266FF"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = main_color
	human_mob.dna.features["mcolor3"] = main_color

/datum/species/skrell/prepare_human_for_preview(mob/living/carbon/human/skrell)
	var/skrell_color = "#22BBFF"
	skrell.dna.features["mcolor"] = skrell_color
	skrell.dna.features["mcolor2"] = skrell_color
	skrell.dna.features["mcolor3"] = skrell_color
	skrell.dna.mutant_bodyparts["skrell_hair"] = list(MUTANT_INDEX_NAME = "Female", MUTANT_INDEX_COLOR_LIST = list(skrell_color, skrell_color, skrell_color))
	regenerate_organs(skrell, src, visual_only = TRUE)
	skrell.update_body(TRUE)


/obj/item/organ/internal/tongue/skrell
	name = "internal vocal sacs"
	desc = "An Strange looking sac."
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "tongue"
	taste_sensitivity = 5
	var/static/list/languages_possible_skrell = typecacheof(list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/machine,
		/datum/language/slime,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/vox,
		/datum/language/nekomimetic,
		/datum/language/skrell,
	))

/obj/item/organ/internal/heart/skrell
	name = "skrellian heart"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "heart"

/obj/item/organ/internal/brain/skrell
	name = "spongy brain"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "brain2"

/obj/item/organ/internal/eyes/skrell
	name = "amphibian eyes"
	desc = "Large black orbs."
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/internal/lungs/skrell
	name = "skrell lungs"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "lungs"
	safe_plasma_max = 40
	safe_co2_max = 40

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 100
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = 380
	heat_level_2_threshold = 400
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/internal/liver/skrell
	name = "skrell liver"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	alcohol_tolerance = 0.002
	toxTolerance = 10 //can shrug off up to 10u of toxins.
	liver_resistance = 0.8 * LIVER_DEFAULT_TOX_RESISTANCE // -20%

/datum/species/skrell/get_species_description()
	return "Hailing from another realm, skrell are adaptable to their enviroment \
		and intend to make this new realm their home to escape the inquisition."

/datum/species/skrell/get_species_lore()
	return list(
		"Skrell were a once powerful race with their home now in ruins. What was once sprawling cities home to \
		technological advancements beyond our wildest dreams, now a husk of its former self. Society reduced back \
		to the medieval age of society with not a soul alive to remember the good days. Now there is only misery on their planet,\
		for the inquisitors make sure of it. ",

		"The planet Qu’ul was, and still is, a planet comprised largely of swamps. Wet mud with temperatures ranging from arid to frozen.\
		The creatures on this planet were mostly amphibious with few exceptions. Creatures of flight were thought to be myth, for they did\
		not roam the planet. One species, the apex species, came to be the Skrell, their flesh soft and froglike, their gills like that of\
		a fish, and their brain most akin to that of a human. There were of course, some differences in the brain compared to a human.\
		Structurally, their brain is more spongy, softer, and most importantly, highly sensitive to psychic abilities. Once upon a time\
		they used such abilities in their day to day, tempered their powers in new and creative ways akin to magic. Thousands of years of progress,\
		slowly destroyed over another thousand years. The collective worries and thoughts of the population collected and became real, slowly at first,\
		but quickly spiraling out of control. What could simply be a common cold spread all around, fears of the unknown disease from around the\
		planet assumed it to be a plague, and thus, from the fears of the people, it became one. From the fears  of this age of death, the\
		idea that death was around the corner manifested at first in animals suddenly snapping, ripping at the Skrell in their despair. Then came\
		the fear of monsters in the dark, causing them to manifest in all sorts of wicked shapes. For now that they knew it was possible, it was truth.\
		A thousand years of fear lead to a new truth however, a truth that their abilities that were once the pinnacle of their society were\
		now nothing more than unclean thoughts, punishments for fear, and a new order lashed out at those who dared use psychic abilities.\
		Although still possible, they forgot their ways, and that part of their spongy blue brain shrunk from generations of\
		unutilized potential. Inquisitors were seen as heroes, those who brought order from the despair.",

		" Yet some were unhappy with the situation and gained a means to escape. Some learned of ways to open gateways to other\
		worlds through a place referred to as the void, unspoken of to anyone outside of those in the know, or the inquisition.\
		The world between words they had to travel from was one of absolute magic. Creatures that can only be described as fae borne\
		existed in this realm. Time itself was inconsistent, warping itself at random, what felt like half an hour could be half\
		a year in the outside world, or 30 years could be 30 seconds. Furthermore, what took a planet of skrell to make real would\
		now only take a few in this realm, even with their abilities weakened from both lack of practice and evolution.\
		The place was as if it was made of pure imagination. Yet one thing was always sure. One who spent any un-needed time in the\
		realm will mutate, sometimes in ways that make them unrecognizable from what they once were. When anyone chooses however,\
		they can leave the realm often finding themselves in our reality. Its often wondered if their home planet has yet to be found,\
		or if they truly are leaving their reality to come to our own.",
	)
