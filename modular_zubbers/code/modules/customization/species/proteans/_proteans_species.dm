/datum/species/protean
	id = SPECIES_PROTEAN
	examine_limb_id = SPECIES_PROTEAN

	name = "\improper Protean"
	sexes = TRUE

	siemens_coeff = 1.5 // Electricty messes you up.
	payday_modifier = 1.0 // the normal amount

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
	var/datum/action/protean/protean_action
	language_prefs_whitelist = list(/datum/language/monkey)

/mob/living/carbon/human/species/protean
	race = /datum/species/protean

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	owner = gainer
	equip_modsuit(gainer)
	RegisterSignal(src, COMSIG_OUTFIT_EQUIP, PROC_REF(outfit_handling))
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	protean_action = new(src)
	protean_action.Grant(owner)
	var/obj/item/mod/core/protean/core = species_modsuit.core
	if(!core)
		CRASH("Protean: [gainer] failed to link to a core, and thus, have a functional suit!")
	core.linked_species = src

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
		species_modsuit.stored_modsuit.forceMove(get_turf(gainer))
		unassimilate_modsuit(null, TRUE)
	if(species_modsuit)
		if(species_modsuit.atom_storage)
			species_modsuit.atom_storage.remove_all(owner.drop_location())
		QDEL_NULL(species_modsuit)
	protean_action.Remove(owner)
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
	if(visuals_only)
		return

	var/obj/item/mod/control/suit = outfit.back
	if(ispath(suit, /obj/item/mod/control))
		suit = new outfit.back
		ASYNC // Not INVOKE_ASYNC to prevent race conditions.
			assimilate_modsuit(owner, suit, TRUE)
			species_modsuit.quick_activation()

	owner.equip_to_storage(SSwardrobe.provide_type(/obj/item/stack/sheet/iron/twenty, owner), ITEM_SLOT_BACK, TRUE, FALSE)
	if(outfit.suit_store)
		owner.equip_to_slot_if_possible(SSwardrobe.provide_type(outfit.suit_store, owner), ITEM_SLOT_SUITSTORE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE)

/datum/species/protean/proc/assimilate_modsuit(mob/living/user, obj/item/mod/control/to_assimilate, forced = FALSE)
	if(species_modsuit.stored_modsuit)
		to_chat(user, span_warning("Can't absorb two modsuits!"))
		if(forced)
			stack_trace("assimilate_modsuit() tried to assimilate two modsuits. stored_modsuit: [species_modsuit.stored_modsuit], new_modsuit: [to_assimilate]")
		return
	if(!user?.transferItemToLoc(to_assimilate, species_modsuit, forced))
		owner.balloon_alert(user, "stuck!")
	if(!forced)
		for(var/obj/item/part as anything in species_modsuit.get_parts())
			if(part.loc == src)
				continue
			species_modsuit.retract(null, part, TRUE)

	species_modsuit.cached_modules += species_modsuit.modules
	species_modsuit.stored_modsuit = to_assimilate
	species_modsuit.stored_theme = species_modsuit.theme
	species_modsuit.complexity_max = species_modsuit.stored_modsuit.complexity_max
	species_modsuit.theme = species_modsuit.stored_modsuit.theme
	species_modsuit.name = species_modsuit.stored_modsuit.name
	species_modsuit.desc = species_modsuit.stored_modsuit.desc
	species_modsuit.extended_desc = species_modsuit.stored_modsuit.extended_desc
	/// module handling
	for(var/obj/item/mod/module/module in species_modsuit.stored_modsuit.modules)
		if(istype(module, /obj/item/mod/module/storage))
			var/obj/item/mod/module/storage/existing_storage = locate() in species_modsuit.modules
			if(existing_storage)
				continue
		if(locate(module.type) in species_modsuit.modules)
			continue
		species_modsuit.stored_modsuit.uninstall(module)
		if(species_modsuit.install(module, owner, TRUE))
			continue
	species_modsuit.theme.set_up_parts(species_modsuit, species_modsuit.theme.default_skin)
	species_modsuit.update_static_data_for_all_viewers()

/datum/species/protean/proc/unassimilate_modsuit(mob/living/user, forced = FALSE)
	if(!species_modsuit.stored_modsuit)
		to_chat(user, span_warning("There is no assimilated suit."))
		return
	if(species_modsuit.active && !forced)
		user.balloon_alert(user, "deactivate modsuit")
		return
	if(!(user?.has_active_hand()) && !forced)
		user.balloon_alert(user, "need active hand")
		return

	for(var/obj/item/part in species_modsuit.get_parts())
		if(part.loc == src)
			continue
		species_modsuit.retract(null, part, instant = TRUE)
	species_modsuit.complexity_max = initial(species_modsuit.complexity_max)

	// Module handling
	for(var/obj/item/mod/module in species_modsuit.modules) // Transfer back every module
		if(locate(module) in species_modsuit.cached_modules)
			continue
		species_modsuit.uninstall(module, user)
		if(!species_modsuit.stored_modsuit.install(module, user, TRUE))
			to_chat(user, span_notice("[module] has fallen to the floor!"))
			module.forceMove(get_turf(species_modsuit))
		species_modsuit.cached_modules -= module

	// Item handling
	for(var/obj/item/stuff in species_modsuit.atom_storage?.real_location.contents)
		if(!species_modsuit.stored_modsuit.atom_storage)
			species_modsuit.atom_storage.remove_all(owner)
			break
		species_modsuit.stored_modsuit.atom_storage.attempt_insert(stuff, owner, TRUE, messages = FALSE)

	species_modsuit.theme = species_modsuit.stored_theme
	species_modsuit.stored_theme = null
	species_modsuit.theme.set_up_parts(species_modsuit, species_modsuit.theme.default_skin)
	species_modsuit.name = initial(species_modsuit.name)
	species_modsuit.desc = initial(species_modsuit.desc)
	species_modsuit.extended_desc = initial(species_modsuit.extended_desc)

	if(user?.can_put_in_hand(species_modsuit.stored_modsuit, user.active_hand_index))
		user.put_in_hand(species_modsuit.stored_modsuit, user.active_hand_index)

	species_modsuit.stored_modsuit = null
	update_static_data_for_all_viewers()

/datum/species/protean/proc/assimilate_theme(mob/user, plating)
	var/obj/item/mod/construction/plating/plates = plating
	var/datum/mod_theme/the_theme = GLOB.mod_themes[plates.theme]

	species_modsuit.name = initial(species_modsuit.name)
	species_modsuit.desc = initial(species_modsuit.desc)

	for(var/obj/item/part in species_modsuit.get_parts())
		part.name = initial(part.name)
		part.desc = initial(part.desc)
		if(part.loc == src)
			continue
		species_modsuit.retract(null, part, instant = TRUE)

	species_modsuit.theme = the_theme
	species_modsuit.theme.set_up_parts(species_modsuit, the_theme.default_skin)
	update_static_data_for_all_viewers()

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

/datum/species/protean/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_REFRESH,
		SPECIES_PERK_NAME = "MODsuit Mode",
		SPECIES_PERK_DESC = "[plural_form] are able to turn into MODsuits, and have some special components available to them. When [plural_form] enter a critical state, they instead withdraw into MODsuit form until a refactory is inserted into them."
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SQUARE_VIRUS,
		SPECIES_PERK_NAME = "Protean Oddities",
		SPECIES_PERK_DESC = "[plural_form] are inorganic beings. They are unable to gain nutrition from traditional foods. Instead, they must consume metals - Primarily, iron. \ In addition to this, [plural_form] are unable to be surgically or chemically healed; [plural_form] regenerate their body over time, consuming their nutrition to do so."
	))

	return perk_descriptions
