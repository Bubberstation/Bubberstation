/datum/species/protean
	id = SPECIES_PROTEAN
	examine_limb_id = SPECIES_PROTEAN

	name = "Protean"
	sexes = TRUE

	siemens_coeff = 1.5 // Electricty messes you up.
	payday_modifier = 0.7 // 30 percent poorer

	exotic_bloodtype = BLOOD_TYPE_NANITE_SLURRY
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	meat = /obj/item/stack/sheet/iron

	mutant_bodyparts = list()
	mutantbrain = /obj/item/organ/brain/protean
	mutantheart = /obj/item/organ/heart/protean
	mutantstomach = /obj/item/organ/stomach/protean
	mutantlungs = null
	mutantliver = /obj/item/organ/liver/protean
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
		TRAIT_VIRUSIMMUNE, // So they can't roll for fake virus, they can't get sick anyways

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
	reagent_flags = PROCESS_PROTEAN

	/// Reference to the
	var/obj/item/mod/control/pre_equipped/protean/species_modsuit

	/// Reference to the species owner
	var/mob/living/carbon/human/owner
	var/list/organ_slots = list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_HEART, ORGAN_SLOT_STOMACH, ORGAN_SLOT_EYES)
	language_prefs_whitelist = list(/datum/language/monkey)

/mob/living/carbon/human/species/protean
	race = /datum/species/protean

/datum/species/protean/Destroy(force)
	QDEL_NULL(species_modsuit)
	owner = null
	. = ..()

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	owner = gainer
	equip_modsuit(gainer)
	RegisterSignal(src, COMSIG_OUTFIT_EQUIP, PROC_REF(outfit_handling))
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	var/obj/item/mod/core/protean/core = species_modsuit.core
	core?.linked_species = src
	var/static/protean_verbs = list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
		/mob/living/carbon/proc/low_power
	)
	add_verb(gainer, protean_verbs)

/datum/species/protean/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted
	if(!(insert_organ.slot in organ_slots))
		return
	if(insert_organ.organ_flags & (ORGAN_ROBOTIC | ORGAN_NANOMACHINE | ORGAN_UNREMOVABLE))
		return
	addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)

/datum/species/protean/proc/reject_now(mob/living/source, obj/item/organ/organ)

	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your mass rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	if(gainer)
		UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
	if(species_modsuit.stored_modsuit)
		species_modsuit.unassimilate_modsuit(owner, TRUE)
	gainer.dropItemToGround(species_modsuit, TRUE)
	if(species_modsuit)
		QDEL_NULL(species_modsuit)
	owner = null

/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	species_modsuit = new()
	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(species_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)

/**
 * Protean Outfit Handling and Logic ----------------------------------------
 * Proteans get really fucky with outfit logic, so I've appended a COMSIG_OUTFIT_EQUIP signal at the end of /datum/outfit/proc/equip.
 * Basically what this does, is once outfit code has been ran, it will go through the assigned outfit again.
 * It assimilates any modsuits, gives you a storage if you're missing it, and places contents into said storage.
 * Yes, this is really snowflakey but I've been bashing my head against the wall for 4 hours trying to figure this out.
 * -------------------------------------------------------------------------- */

/datum/species/protean/proc/outfit_handling(datum/species/protean, datum/outfit/outfit, visuals_only) // Very snowflakey code. I'm not making outfits for every job.
	SIGNAL_HANDLER
	var/get_a_job = istype(outfit, /datum/outfit/job)
	var/obj/item/mod/control/suit
	if(ispath(outfit.back, /obj/item/mod/control))
		var/control_path = outfit.back
		suit = new control_path()
		INVOKE_ASYNC(species_modsuit, TYPE_PROC_REF(/obj/item/mod/control/pre_equipped/protean, assimilate_modsuit), owner, suit, TRUE)
		INVOKE_ASYNC(species_modsuit, TYPE_PROC_REF(/obj/item/mod/control, quick_activation))

	var/obj/item/mod/module/storage/storage = locate() in species_modsuit.modules // Give a storage if we don't have one.
	if(!storage)
		storage = new()
		species_modsuit.install(storage, owner, TRUE)

	if(outfit.backpack_contents)
		outfit.backpack_contents += /obj/item/stack/sheet/iron/twenty
		for(var/path in outfit.backpack_contents)
			if(!get_a_job)
				continue
			var/number = outfit.backpack_contents[path]
			if(!isnum(number))//Default to 1
				number = 1
			for(var/i in 1 to number) // Copy and paste of EQUIP_OUTFIT_ITEM
				owner.equip_to_storage(SSwardrobe.provide_type(path, owner), ITEM_SLOT_BACK, TRUE, TRUE)

/datum/species/protean/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE)
	)

/datum/species/protean/allows_food_preferences()
	return FALSE

/datum/species/protean/get_species_description()
	return list(
			"Trillions of small machines swarm into a single crewmember. This is a Protean, a walking coherent blob of metallic mass, and a churning factory that turns materials into more of itself. \
			Proteans are unkillable. Instead, they shunt themselves away into their core when catastrophic losses to their swarm occur. Their cores also mimic the functions of a modsuit and can even assimilate more functional suits to use. \
			Proteans only have a few vital organs, which can only be replaced via cargo. Their refactory is a miniature factory, and without it, they will face slow, agonizing degradation. Their Orchestrator is a miniature processor required for ease of movement. \
			Proteans are an extremely fragile species, weak in combat, but a powerful aid, or a puppeteer pulling the strings.")
