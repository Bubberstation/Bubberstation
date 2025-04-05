/datum/species/protean
	id = SPECIES_PROTEAN
	examine_limb_id = SPECIES_PROTEAN

	name = "Protean"
	sexes = TRUE

	siemens_coeff = 1.5 // Electricty messes you up.
	payday_modifier = 0.7 // 30 percent poorer

	exotic_blood = /datum/reagent/medicine/nanite_slurry
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	meat = /obj/item/stack/sheet/iron

	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/protean
	mutantheart = /obj/item/organ/heart/protean
	mutantstomach = /obj/item/organ/stomach/protean
	mutantlungs = null
	mutantliver = null
	mutantappendix = null
	mutanteyes = /obj/item/organ/eyes/robotic/protean
	mutantears = /obj/item/organ/ears/cybernetic/protean
	mutanttongue = /obj/item/organ/tongue/cybernetic/protean

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/protean,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/protean,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/protean,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/protean,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/protean,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/protean,
	)

	inherent_traits = list(
		// Default Species
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,

		// Needed to exist without dying and robot specific stuff.
		TRAIT_NOBREATH,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_ROCK_EATER,
		TRAIT_STABLEHEART, // TODO: handle orchestrator code
		TRAIT_NOHUNGER, // They will have metal stored in the stomach. Fuck nutrition code.
		TRAIT_LIMBATTACHMENT,

		// Synthetic lifeforms
		TRAIT_GENELESS,
		TRAIT_NO_HUSK,
		TRAIT_NO_DNA_SCRAMBLE,
		TRAIT_SYNTHETIC, // Not used in any code, but just in case
		TRAIT_TOXIMMUNE,
		TRAIT_NEVER_WOUNDED, // Does not wound.

		// Extra cool stuff
		TRAIT_RADIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_RDS_SUPPRESSED,
		TRAIT_MADNESS_IMMUNE,

		// Seperate handling will be used. Proteans never truely "die". They get stuck in their suit.
		TRAIT_NODEATH,

		//TRAIT_VENTCRAWLER_NUDE, - A tease. If you want to give a species vent crawl. God help your soul. But I won't stop you from learning that hard lesson.
	)

	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	reagent_flags = null

	/// Reference to the
	var/obj/item/mod/control/pre_equipped/protean/species_modsuit

	/// Reference to the species owner
	var/mob/living/carbon/human/owner

/datum/species/protean/Destroy(force)
	if(species_modsuit)
		QDEL_NULL(species_modsuit)
	owner = null
	return ..()

/mob/living/carbon/human/species/protean
	race = /datum/species/protean

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	owner = gainer

	equip_modsuit(gainer)
	var/obj/item/mod/core/protean/core = species_modsuit.core
	core?.linked_species = src
	var/static/protean_verbs = list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
	)
	add_verb(gainer, protean_verbs)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	owner = null
	gainer.dropItemToGround(species_modsuit, TRUE)
	QDEL_NULL(species_modsuit)

/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	species_modsuit = new()
	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(species_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)

/datum/species/protean/allows_food_preferences()
	return FALSE
