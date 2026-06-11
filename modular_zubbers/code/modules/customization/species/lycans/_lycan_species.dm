#define DOAFTER_SOURCE_LYCAN_DOOR_PRY "lycan door pry"

/datum/species/lycan
	id = SPECIES_LYCAN
	examine_limb_id = SPECIES_LYCAN

	name = "\improper Lycan"
	sexes = TRUE

	coldmod = 0.67 // They have thick fur so I guess this makes sense.
	heatmod = 1.3

	digitigrade_customization = DIGITIGRADE_FORCED

	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/lycan
	mutantheart = /obj/item/organ/heart/lycan
	mutantstomach = /obj/item/organ/stomach/lycan
	mutantlungs = /obj/item/organ/lungs/lycan
	mutantliver = /obj/item/organ/liver/lycan
	mutantappendix = null // Wolves don't have appendixes
	mutanteyes = /obj/item/organ/eyes/lycan
	mutantears = /obj/item/organ/ears/lycan
	mutanttongue = /obj/item/organ/tongue/lycan

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/lycan,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/lycan,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/lycan,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/lycan,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/lycan,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/lycan,
	)

	inherent_traits = list(
		// Default Species
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS_2,
		TRAIT_NO_UNDERWEAR, // They should still be able to toggle genitals if needed.
		// Lycan Specific Things
		TRAIT_LUPINE,
		TRAIT_BEAST_FORM,
		TRAIT_LYCAN,
		TRAIT_QUICKER_CARRY, // It'd be on par with nitrile gloves.
		TRAIT_PIERCEIMMUNE, // Thick skin
		TRAIT_CHUNKYFINGERS,
		TRAIT_FAST_METABOLISM,
	)

	no_equip_flags = ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_EYES | ITEM_SLOT_BACK
	always_customizable = TRUE
	sort_bottom = TRUE

/datum/species/lycan/prepare_human_for_preview(mob/living/carbon/human/lycan)
	var/main_color = "#362d23"
	var/secondary_color = "#bb1607"
	var/tertiary_color = "#CCF6E2"
	lycan.dna.features["mcolor"] = main_color
	lycan.dna.features["mcolor2"] = secondary_color
	lycan.dna.features["mcolor3"] = tertiary_color
	lycan.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	lycan.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Wolf", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	lycan.dna.features["legs"] = "Digitigrade Legs"
	regenerate_organs(lycan, src, visual_only = TRUE)
	lycan.update_body(TRUE)

/mob/living/carbon/human/species/lycan
	race = /datum/species/lycan

/datum/species/lycan/get_species_description()
	return list("The transformed version of a Cursekin. Only available for customization of a Cursekin's transformed form.")

/datum/species/lycan/get_species_lore()
	return list("See Cursekin lore.")

/datum/species/lycan/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_ROBOT,
			SPECIES_PERK_NAME = "Inorganic rejection",
			SPECIES_PERK_DESC = "The curse afflicting the cursekin prevents their bodies from being augmented with cybernetic organs \
			or implants."
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_CLOUD_MOON,
			SPECIES_PERK_NAME = "Silver weakness",
			SPECIES_PERK_DESC = "You are burnt by silver, including silver weaponry."
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_GUN,
			SPECIES_PERK_NAME = "Chunky fingers",
			SPECIES_PERK_DESC = "While in Lycan form, you cannot use guns without special trigger-guards, nor batons.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_SHIRT,
			SPECIES_PERK_NAME = "Unclothable",
			SPECIES_PERK_DESC = "While in Lycan form, you drop all your clothing to the floor.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_MOON,
			SPECIES_PERK_NAME = "Lycan strength",
			SPECIES_PERK_DESC = "While in Lycan form, your claws deal significant damage - about circular saw level.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_SHIELD,
			SPECIES_PERK_NAME = "Lycan resilience",
			SPECIES_PERK_DESC = "While in Lycan form, you take 50% less brute and 20% less burn.",
		),
	)

	return to_add

/datum/species/lycan/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()

	RegisterSignal(gainer, COMSIG_LIVING_BANED, PROC_REF(on_baned))

	if (HAS_TRAIT(gainer, TRAIT_GAIAN_PHYSIQUE))
		handle_gaian_physique(gainer)

/datum/species/lycan/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	. = ..()

	UnregisterSignal(loser, COMSIG_LIVING_BANED)

	if (HAS_TRAIT(loser, TRAIT_GAIAN_PHYSIQUE))
		handle_gaian_physique_loss(loser)

/datum/species/lycan/proc/handle_gaian_physique(mob/living/carbon/human/gainer)
	stunmod = 0.5
	gainer.physiology.stamina_mod *= 0.25

	var/obj/item/bodypart/arm/l_arm = gainer.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/arm/r_arm = gainer.get_bodypart(BODY_ZONE_R_ARM)

	// near esword level, though without blockchance
	l_arm?.unarmed_damage_low = 27
	l_arm?.unarmed_damage_high = 27
	r_arm?.unarmed_damage_low = 27
	r_arm?.unarmed_damage_high = 27
	l_arm?.unarmed_effectiveness = 75 // massively increases damage on grabbed targets
	r_arm?.unarmed_effectiveness = 75

	ADD_TRAIT(gainer, TRAIT_BATON_RESISTANCE, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_HARDLY_WOUNDED, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_FEARLESS, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_NO_STAGGER, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_NO_THROW_HITPUSH, SPECIES_TRAIT)
	ADD_TRAIT(gainer, TRAIT_MARTIAL_ARTS_UNUSABLE, SPECIES_TRAIT)

	gainer.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	gainer.AddComponent( \
		/datum/component/regenerator, \
		regeneration_delay = 5 SECONDS, \
		brute_per_second = 5, \
		burn_per_second = 1, \
		tox_per_second = 0.5, \
		oxy_per_second = 0.5, \
		ignore_damage_types = list(), \
	)

	var/datum/action/extend_lycan_claws/claws_action = new(src)
	claws_action.Grant(gainer)

/datum/species/lycan/proc/handle_gaian_physique_loss(mob/living/carbon/human/loser)
	REMOVE_TRAIT(loser, TRAIT_BATON_RESISTANCE, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_HARDLY_WOUNDED, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_FEARLESS, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_NO_STAGGER, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_NO_THROW_HITPUSH, SPECIES_TRAIT)
	REMOVE_TRAIT(loser, TRAIT_MARTIAL_ARTS_UNUSABLE, SPECIES_TRAIT)

	loser.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	qdel(loser.GetComponent(/datum/component/regenerator))

	var/datum/action/extend_lycan_claws/claws_action = locate() in loser.actions
	if (claws_action)
		qdel(claws_action)

	loser.physiology.stamina_mod *= 4

	// already lost the limb shit

/datum/species/lycan/proc/on_baned(mob/living/carbon/human/baned, mob/user)
	SIGNAL_HANDLER

	baned.visible_message(span_warning("[baned] seems to react negatively to the silver, [baned.p_their()] flesh scorching and burning on contact!"), ignored_mobs = list(baned))
	to_chat(baned, span_bolddanger("The sister moon casts its light on you, and you feel your flesh scorch!"))
	INVOKE_ASYNC(baned, TYPE_PROC_REF(/mob, emote), "scream")

#undef DOAFTER_SOURCE_LYCAN_DOOR_PRY
