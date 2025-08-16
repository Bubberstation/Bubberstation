/datum/species/ghoul
	name = "Ghoul"
	id = SPECIES_GHOUL
	examine_limb_id = SPECIES_GHOUL
	can_have_genitals = FALSE //WHY WOULD YOU WANT TO FUCK ONE OF THESE THINGS?
	mutant_bodyparts = list("ghoulcolor" = "Tan Necrotic")
	mutanttongue = /obj/item/organ/tongue/ghoul
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_EASILY_WOUNDED, //theyre like fuckin skin and bones
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
		TRAIT_FIXED_MUTANT_COLORS,
	)
	payday_modifier = 1.0 //-- "Equality"
	stunmod = 1.25 //multiplier for stun durations
	bodytemp_normal = T20C
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/ghoul,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/ghoul,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/ghoul,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/ghoul,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/ghoul,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/ghoul,
	)
	//the chest and head cannot be turned into meat
	//i dont have to worry about sprites due to limbs_icon, thank god
	//also the head needs to be normal for hair to work

	/// Body parts that the ghoul can pull off or have reattached
	var/static/list/swappable_parts = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/datum/species/ghoul/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/ghoul/get_species_description()
	return list(placeholder_description,)

/proc/proof_ghoul_features(list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if(inFeatures["ghoulcolor"] == null || inFeatures["ghoulcolor"] == "")
		inFeatures["ghoulcolor"] = GLOB.color_list_ghoul[pick(GLOB.color_list_ghoul)]

/datum/species/ghoul/proc/set_ghoul_color(mob/living/carbon/human/human_ghoul)
	// Called on Assign, or on Color Change (or any time proof_ghoul_features() is used)
	fixed_mut_color = human_ghoul.dna.features["ghoulcolor"]

/datum/species/ghoul/on_species_gain(mob/living/carbon/new_ghoul, datum/species/old_species, pref_load, regenerate_icons)
	// Missing Defaults in DNA? Randomize!
	proof_ghoul_features(new_ghoul.dna.features)

	. = ..()

	if(ishuman(new_ghoul))
		var/mob/living/carbon/human/human_ghoul = new_ghoul

		set_ghoul_color(human_ghoul)

		// 2) BODYPARTS
		RegisterSignal(human_ghoul, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(attach_meat))
		human_ghoul.part_default_head = /obj/item/bodypart/head/mutant/ghoul
		human_ghoul.part_default_chest = /obj/item/bodypart/chest/mutant/ghoul
		human_ghoul.part_default_l_arm = /obj/item/bodypart/arm/left/mutant/ghoul
		human_ghoul.part_default_r_arm = /obj/item/bodypart/arm/right/mutant/ghoul
		human_ghoul.part_default_l_leg = /obj/item/bodypart/leg/left/mutant/ghoul
		human_ghoul.part_default_r_leg = /obj/item/bodypart/leg/right/mutant/ghoul

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/former_ghoul, datum/species/new_species, pref_load)
	. = ..()

	// 2) BODYPARTS
	UnregisterSignal(former_ghoul, COMSIG_ATOM_ITEM_INTERACTION)
	former_ghoul.part_default_head = /obj/item/bodypart/head
	former_ghoul.part_default_chest = /obj/item/bodypart/chest
	former_ghoul.part_default_l_arm = /obj/item/bodypart/arm/left
	former_ghoul.part_default_r_arm = /obj/item/bodypart/arm/right
	former_ghoul.part_default_l_leg = /obj/item/bodypart/leg/left
	former_ghoul.part_default_r_leg = /obj/item/bodypart/leg/right

/*
*	ATTACK PROCS
*/

/datum/species/ghoul/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (user != target)
		return ..()

	var/target_zone = user.zone_selected
	var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target

	if (!(target_zone in swappable_parts) || !affecting)
		return ..()

	if (user.handcuffed)
		to_chat(user, span_alert("You can't get a good enough grip with your hands bound."))
		return FALSE

	// Robot Arms Fail
	if (!IS_ORGANIC_LIMB(affecting))
		to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
		return FALSE

	// Pry it off...
	user.visible_message("[user] grabs onto [p_their()] own [affecting.name] and pulls.", span_notice("You grab hold of your [affecting.name] and yank hard."))
	if (!do_after(user, 3 SECONDS, target))
		return FALSE

	user.visible_message("[user]'s [affecting.name] comes right off in their hand.", span_notice("Your [affecting.name] pops right off."))
	playsound(get_turf(user), 'sound/effects/meatslap.ogg', 40, 1) //ill change these sounds later

	// Destroy Limb, Drop Meat, Pick Up
	var/obj/item/I = affecting.drop_limb()
	if (istype(I, /obj/item/food/meat/slab))
		user.put_in_hands(I)

	new /obj/effect/temp_visual/dir_setting/bloodsplatter(target.loc, target.dir)
	target.add_splatter_floor(target.loc)
	target.bleed(60)

	return TRUE

/datum/species/ghoul/proc/attach_meat(mob/living/carbon/human/target, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(!istype(target))
		return NONE

	// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
	if(target.stat == DEAD || !istype(tool, /obj/item/food/meat/slab))
		return NONE

	var/target_zone = user.zone_selected
	if(target.get_bodypart(target_zone)) // we already have a limb here
		return NONE

	if(!(target_zone in swappable_parts))
		return NONE

	user.visible_message("[user] begins mashing [tool] into [target]'s torso.", span_notice("You begin mashing [tool] into [target == user ? "your" : "[target]'s"] torso."))

	// Leave Melee Chain (so deleting the meat doesn't throw an error) <--- aka, deleting the meat that called this very proc.
	ASYNC
		if(do_after(user, 3 SECONDS, target))
			// Attach the part!
			var/obj/item/bodypart/newBP = target.newBodyPart(target_zone, FALSE)
			target.visible_message("The meat sprouts digits and becomes [target]'s new [newBP.name]!", span_notice("The meat sprouts digits and becomes your new [newBP.name]!"))
			newBP.try_attach_limb(target)
			qdel(tool)
			playsound(get_turf(target), 'sound/effects/meatslap.ogg', 50, 1)

	return ITEM_INTERACT_SUCCESS

/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/arm/left/part_default_l_arm = /obj/item/bodypart/arm/left
	var/obj/item/bodypart/arm/right/part_default_r_arm = /obj/item/bodypart/arm/right
	var/obj/item/bodypart/leg/left/part_default_l_leg = /obj/item/bodypart/leg/left
	var/obj/item/bodypart/leg/right/part_default_r_leg = /obj/item/bodypart/leg/right

/datum/species/ghoul/get_species_lore()
	return list(placeholder_lore)

/datum/species/ghoul/prepare_human_for_preview(mob/living/carbon/human/human)
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
