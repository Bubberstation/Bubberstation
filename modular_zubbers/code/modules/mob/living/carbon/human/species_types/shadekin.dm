/datum/species/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	eyes_icon = 'modular_zubbers/icons/mob/human/human_face.dmi'
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
	features["mcolor"] = main_color
	features["mcolor2"] = secondary_color
	features["mcolor3"] = tertiary_color
	return features

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#b8b8b8"
	var/tertiary_color = "#b8b8b8"
	shadekin.dna.features["mcolor"] = main_color
	shadekin.dna.features["mcolor2"] = secondary_color
	shadekin.dna.features["mcolor3"] = tertiary_color
	shadekin.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.eye_color_left = "#c4c400"
	shadekin.eye_color_right = "#c4c400"
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
		"It is unclear when exactly Shadekin first began showing up, though it is assumed that it is a relatively recent development. \
		They formed in dark and abandoned places where they are not witnessed-- observation would dispel their creation. \
		When the process is complete, the Shadekin collects the ability to move its limbs and communicate from the surrounding minds \
		and finally, it forms its first thought, the realization that it is alive.",

		"Shadekin are pitch darkness given form, with light seeming to pass through their bodies, which tires them. They do not cast shadows. \
		Shadekin elude common definition in terms of size and appearance, as no two Shadekin are the same-- they often share features with the species around them \
		that would otherwise not be seen as Shadekin features. For example, Shadekin created in Tizira are much more likely to have horns or frill-like ears. \
		A truly average Shadekin would be slightly shorter than a human, with a comparable lifespan.",

		"Shadekin are capable of reproducing sexually, though their minds need diverse surroundings to properly develop, making them fairly self-guided, \
		with little in the way of direction provided by their society. Shadekin that do not make use of another species' naming conventions often \
		name themselves after their place in the community, often a job or societal function. Shadekin easily find a space of their own, and become staples of their communities. \
		They are generally more expressive than other species to compensate for a lack of psionic connection that Shadekin tend to expect from each other. \
		Their language, Marish, is purely empathic and cannot be spoken by psychopaths. Their eye color is often an important part of their biology, as it indicates temperament.",

		"A shadekin trying to navigate the sea of stars is not truly alone, however, as Shadekin have formed in number on the treacherous moon Neoma. \
		While there is no central Shadekin government, this is the closest thing Shadekin have to a homeworld, which remains in total darkness due to its orbit around Lusine, an extremely hot world that keeps Neoma's surface approaching habitable. \
		It has become a notable tourist attraction in the few habitable areas. Neoma also serves an important function of containing the collective knowledge and many of the covens of Shadekin society.",

		"Covens are groups of Shadekin of similar thought formed to maintain themselves and records of their existence, as well as guide new Shadekin \
		as they develop. They are rarely associated with ideology, rather concepts and what they imply, and within a coven exist Coteries, subfactions \
		of interest within a coven, tailored to a specific task and aspect. In this regard, covens are societies in and of themselves, organized in a somewhat tribal manner. \
		Covens do not solely exist on Neoma, they are spread throughout the universe, but most covens at least have some form of archive on the moon, called \"Mindtrusts\".",
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
