/datum/species
	var/sort_bottom = FALSE
//Whether or not a given species is sorted to the bottom of the list. We mainly want to do this for species that are used only for ghostroles, and template species.

/// Called once the target is made into a bloodsucker. Used for removing conflicting species organs mostly
/datum/species/proc/on_bloodsucker_gain(mob/living/carbon/human/target)
	return null

/datum/species/proc/on_bloodsucker_loss(mob/living/carbon/human/target)
	return null

/datum/species/proc/create_pref_brain_perks()
	RETURN_TYPE(/list)

	if(isnull(mutantbrain) || (TRAIT_BRAINLESS_CARBON in inherent_traits))
		return null

	var/list/to_add = list()

	var/brain_flags = initial(mutantbrain.organ_flags)

	if ((brain_flags & ORGAN_ROBOTIC) && (brain_flags & ORGAN_ORGANIC))
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BRAIN,
			SPECIES_PERK_NAME = "Cortical Augmentation",
			SPECIES_PERK_DESC = "[plural_form] have an augmented brain, making them vulnerable to EMPs. On the bright side, their brains can be repaired with a multitool.",
		))

	if ((brain_flags & ORGAN_ROBOTIC) && !(brain_flags & ORGAN_ORGANIC))
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_BRAIN,
			SPECIES_PERK_NAME = "Superior Cortical Augmentation",
			SPECIES_PERK_DESC = "[plural_form] have an augmented brain: Their brains can be repaired with a multitool, and aren't at risk from biological processes. However, they are vulnerable to EMPs",
		))

	return to_add


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
