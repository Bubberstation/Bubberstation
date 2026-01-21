/datum/species/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	mutanttongue = /obj/item/organ/tongue/shadekin
	mutantears = /obj/item/organ/ears/shadekin
	mutantbrain = /obj/item/organ/brain/shadekin
	mutanteyes = /obj/item/organ/eyes/shadekin
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadekin,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION,
		TRAIT_NOBREATH

	)
	species_language_holder = /datum/language_holder/shadekin


/datum/species/shadekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "Dark Regeneration",
		SPECIES_PERK_DESC = "Shadekins regenerate their physical wounds while in the darkness."
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "crutch",
		SPECIES_PERK_NAME = "Light Averse",
		SPECIES_PERK_DESC = "Shadekins move slightly slower while in the light."
	))

	return to_add

/datum/species/shadekin/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Shadekin", TRUE),
		"snout" = list("None", FALSE),
		"ears" = list("Shadekin", TRUE),
		"legs" = list("Normal Legs", TRUE),
	)

/datum/species/shadekin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#202020"
			secondary_color = "#505050"
			tertiary_color = "#3f3f3f"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#b8b8b8"
	var/tertiary_color = "#b8b8b8"
	shadekin.dna.features[FEATURE_MUTANT_COLOR] = main_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	shadekin.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.set_eye_color("#5ec7e4")
	regenerate_organs(shadekin, src, visual_only = TRUE)
	shadekin.update_body(TRUE)

/datum/species/shadekin/get_species_description()
	return list(
		"Shadekin first came about like dust bunnies that collect under a bed, of the collective consciousness \
		\"Welcome, sibling,\" the first words felt in a sea of thought, guiding them to their first connection",
		"Shadekin do not respirate, and their bodies are reformed in the darkness, although frail."
	)

/datum/species/shadekin/get_species_lore()
	return list(
		"It is unclear when exactly Shadekin first spawned, though it is assumedly a relatively recent development. \
		They formed in dark and abandoned places where they are not witnessed-- observation would dispel their creation. \
		When the process completed, the Shadekin collected its ability to move its limbs and communicate from surrounding minds \
		and finally, it formed its first thought, the realization that it is alive.",

		"Shadekin are pitch darkness given form. Light seems to pass through their bodies, which tires them. They do not cast shadows. \
		Shadekin elude definition in terms of size and appearance, as no two Shadekin are the same-- they tend to take features from the species around them \
		that would otherwise not be seen as theirs. For example, Shadekin spawned in Tizira tend to have horns or frill-like ears. \
		An average Shadekin would be slightly shorter than a human, with a similar lifespan. Shadekin that do not use other species' naming conventions will \
		tend to name themselves after their place in the community, like a job or societal function.",

		"Shadekin are capable of reproducing sexually, though their minds need diverse surroundings to properly develop, making them fairly self-guided. \
		Despite this, Shadekin easily find a space of their own, and become staples of their communities. They are more expressive than other species to compensate for a lack of psionic connection. \
		Their language, Marish, is purely empathic and cannot be spoken by psychopaths. Their eye color is an important part of their biology, as it indicates temperament.",

		"A shadekin is never truly alone, however, as Shadekin have formed in number on the treacherous moon Neoma, due to its darkness and isolation. \
		While there is no central Shadekin government, this is the closest thing Shadekin have to a homeworld, devoid of light due to its orbit around Lusine, an extremely hot world that keeps Neoma's surface approaching habitable. \
		It has become a notable tourist attraction in the few habitable areas. Neoma serves an important function of containing the collective knowledge of Shadekin society and its covens.",

		"Covens are groups of Shadekin formed to maintain themselves and records of their existence, as well as guide new Shadekin as they develop. \
		They are rarely associated with ideology alone, rather concepts and what they imply, and within a coven exist Coteries, interest groups within a coven, tailored to a specific aspect. \
		In this regard, covens are societies in and of themselves, organized in a somewhat tribal manner. Covens do not solely exist on Neoma, they are spread throughout the universe, \
		but most covens at least have archives on the moon, called \"Mindtrusts\".",
	)

/obj/item/organ/brain/shadekin
	name = "shadekin brain"
	desc = "A mysterious brain."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"
	var/applied_status = /datum/status_effect/shadekin_regeneration

/obj/item/organ/brain/shadekin/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()

	if (light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD) //heal in the dark
		owner.apply_status_effect(applied_status)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/light_averse)
	else
		owner.add_movespeed_modifier(/datum/movespeed_modifier/light_averse)

/datum/status_effect/shadekin_regeneration
	id = "shadekin_regeneration"
	duration = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/shadekin_regeneration

/datum/status_effect/shadekin_regeneration/on_apply()
	. = ..()
	if (!.)
		return FALSE
	heal_owner()
	return TRUE

/datum/status_effect/shadekin_regeneration/refresh(effect)
	. = ..()
	heal_owner()

/datum/status_effect/shadekin_regeneration/proc/heal_owner()
	owner.heal_overall_damage(brute = 0.5, burn = 0.5, required_bodytype = BODYTYPE_ORGANIC)

/atom/movable/screen/alert/status_effect/shadekin_regeneration
	name = "Dark Regeneration"
	desc = "Feeling the tug of home on your fur, some of its soothing warmth comes to ease your burdens."
	icon_state = "lightless"

/datum/movespeed_modifier/light_averse
	multiplicative_slowdown = 0.25
