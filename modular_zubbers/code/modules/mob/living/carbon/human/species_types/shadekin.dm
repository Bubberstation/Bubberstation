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

/datum/species/shadekin/get_species_description()
	return list("https://citadel-station.net/wikiRP/index.php?title=Species/Shadekin ",

			"Shadekin (singular Shadekin, plural Shadekin) are a species of seemingly mammal creatures, closely resembling canines with four ears. \
			Their own name for their species is Lumelea (singular Lumelea, plural Lumelea), but many \
			did adopt the name Shadekin given how widespread it has become. The colors of their eyes holds great significance \
			in their culture. ",

			"Shadekin live in tribes all across the Galaxy, often in environments that would not support life for most other species. \
			They originate from the planet Azuel I in the Azuel system, a death world that orbits a small black hole, \
			forcing the fauna and flora that lives there to adapt to a cold, dark, and radioactive environment. \
			Shadekin formed smaller, specialized tribes that benefited from cooperative experitise, where eye colors \
			influenced, but not dictated, the roles that individuals take. ",

			"When hatched, a Shadekin usually inherits the eye color of their mother. The eye color is representative for the mentality \
			a Shadekin has. As a Shadekin grows over their lives, long-lasting changes in mentality and personality can change their eye color. \
			A crucial step for young Shadekin is The Ritual, in which they will train their symbolic Bluespace muscle in order to \
			become strong enough to achieve short-range teleportation. Rarely, this can fail, and an unsuccessful Shadekin can burn out, \
			stunting the flow of Bluespace particles through their body and turning their eyes black. This can also occur later in life due to overuse. ",

			"The only eye colors that are not tied to specific personalities are white and black. Those with white eye colors do not change \
			their eye color, and neither do other eye colors change to white. White-eyed are a rarity, being naturally stronger, faster, and \
			more durable than other Shadekin. Their control over Bluespace manipulation far exceeds other Shadekin, being able to teleport \
			without restriction over long distances. Due to the exceeding natural abilities of white-eyed Shadekin, it is not feasable \
			for players to play one without admin intervention. ",

			"As eye colors are tied to personality and responses, it is generally observed that: ",
			"Blue = Natural idealists with outgoing personalities ",
			"Red = Determined and confrontational, projecting ruthless rationality ",
			"Yellow = Notably shy, but passionate and creative ",
			"Green = Intuitive, yet introverted, with unconventional perspectives ",
			"Purple = Reserved, with a careful and methodical way of thinking ",
			"Orange = Eager, vibrant, and spontaneous, with very social impulses ",
			"Black = Shadekin who got burned out, often seen living among other species ",
			"White = Very rare, stronger and more durable than others, vastly varying personalities",
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
