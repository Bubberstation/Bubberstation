/datum/species
	var/placeholder_description = "Placeholder Description! Will you be the only to write a description?  (Contact a maintainer today!)"
	var/placeholder_lore = "Placeholder Lore! Will you be the one to add lore here? (Contact a maintainer today!)"
	var/remove_features = FALSE
	payday_modifier = 1.0

/// Called once the target is made into a bloodsucker. Used for removing conflicting species organs mostly
/datum/species/proc/on_bloodsucker_gain(mob/living/carbon/human/target)
	return null

/datum/species/proc/on_bloodsucker_loss(mob/living/carbon/human/target)
	return null

/// Replaces a couple organs to normal variants to not cause issues. Not super happy with this, alternative is disallowing vampiric races from being bloodsuckers
/datum/species/proc/humanize_organs(mob/living/carbon/human/target, organs = list())
	if(!organs || !length(organs))
		organs = list(
			ORGAN_SLOT_HEART = /obj/item/organ/heart,
			ORGAN_SLOT_LIVER = /obj/item/organ/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
			ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		)
	mutantheart = organs[ORGAN_SLOT_HEART]
	mutantliver = organs[ORGAN_SLOT_LIVER]
	mutantstomach = organs[ORGAN_SLOT_STOMACH]
	mutanttongue = organs[ORGAN_SLOT_TONGUE]
	for(var/organ_slot in organs)
		var/obj/item/organ/old_organ = target.get_organ_slot(organ_slot)
		var/organ_path = organs[organ_slot]
		if(old_organ?.type == organ_path)
			continue
		var/obj/item/organ/new_organ = SSwardrobe.provide_type(organ_path)
		new_organ.Insert(target, FALSE, DELETE_IF_REPLACED)

/datum/species/proc/normalize_organs(mob/living/carbon/human/target)
	mutantheart = initial(mutantheart)
	mutantliver = initial(mutantliver)
	mutantstomach = initial(mutantstomach)
	mutanttongue = initial(mutanttongue)
	regenerate_organs(target, replace_current = TRUE)


/datum/species/get_species_description()
	SHOULD_CALL_PARENT(FALSE)

	//stack_trace("Species [name] ([type]) did not have a description set, and is a selectable roundstart race! Override get_species_description.")
	return list("No species description set, file a bug report!",)


/datum/species/monkey
	remove_features = TRUE // No more monkeys with tits, sorry

/datum/species/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	if(remove_features)
		human_who_gained_species.dna.mutant_bodyparts = list()
		human_who_gained_species.dna.body_markings = list()
	. = ..()

/// Tries to override our bodypart_overrides with digi varieties
/// Doesnt actually give us the limbs, you might have to call replace_body after this
/datum/species/proc/try_make_digitigrade(mob/living/carbon/human/human_who_gained_species)
	var/ignore_digi = FALSE // You can jack into this var with other checks, if you want.
	if(type == /datum/species/synthetic)
		var/list/chassis = human_who_gained_species.dna.mutant_bodyparts[MUTANT_SYNTH_CHASSIS]
		if(chassis)
			var/list/chassis_accessory = SSaccessories.sprite_accessories[MUTANT_SYNTH_CHASSIS]
			var/datum/sprite_accessory/synth_chassis/body_choice
			if(chassis_accessory)
				body_choice = chassis_accessory[chassis[MUTANT_INDEX_NAME]]
			if(body_choice && !body_choice.is_digi_compatible)
				ignore_digi = TRUE

	if(!ignore_digi && ((digitigrade_customization == DIGITIGRADE_OPTIONAL && human_who_gained_species.dna.features["legs"] == DIGITIGRADE_LEGS) || digitigrade_customization == DIGITIGRADE_FORCED))
		var/obj/item/bodypart/leg/right/r_leg = bodypart_overrides[BODY_ZONE_R_LEG]
		if(r_leg)
			bodypart_overrides[BODY_ZONE_R_LEG] = initial(r_leg.digitigrade_type)
		var/obj/item/bodypart/leg/left/l_leg = bodypart_overrides[BODY_ZONE_L_LEG]
		if(l_leg)
			bodypart_overrides[BODY_ZONE_L_LEG] = initial(l_leg.digitigrade_type)
