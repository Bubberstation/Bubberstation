/// The organ was absent because the species simply doesn't have one.
#define ORGAN_ABSENCE_SPECIES_NORMAL -1
/// The organ should have been there and wasn't.
#define ORGAN_ABSENCE_INJURY -2

/// This component tracks the original damage values of a mob when it is attached.
/datum/component/damage_tracker
	/// How much brute damage did the mob have on them?
	var/brute_damage = 0
	/// How much burn damage did the mob have on them?
	var/burn_damage = 0
	/// How much oxygen damage did the mob have on them?
	var/oxygen_damage = 0
	/// How much toxin damage did the mob have on them?
	var/toxin_damage = 0

	/// How much blood did the mob have?
	var/stored_blood_volume = 0

	/// Do we need to reapply the damage values when this component is removed?
	var/reapply_damage_on_removal = TRUE

/// Updates the stored damage variables for the parent mob. Returns `TRUE` when succesfully ran, otherwise returns `FALSE`
/datum/component/damage_tracker/proc/update_damage_values()
	var/mob/living/tracked_mob = parent
	if(!istype(tracked_mob))
		return FALSE

	brute_damage = tracked_mob.get_brute_loss()
	burn_damage = tracked_mob.get_fire_loss()
	toxin_damage = tracked_mob.get_tox_loss()
	oxygen_damage = tracked_mob.get_oxy_loss()
	stored_blood_volume = tracked_mob.blood_volume

	return TRUE

/// Reapplies the stored damage variables to the parent mob. Returns `TRUE` when succesfully ran, otherwise returns `FALSE`
/datum/component/damage_tracker/proc/reapply_damage()
	var/mob/living/tracked_mob = parent
	if(!istype(tracked_mob))
		return FALSE

	tracked_mob.set_brute_loss(brute_damage)
	tracked_mob.set_fire_loss(burn_damage)
	tracked_mob.set_tox_loss(toxin_damage)
	tracked_mob.set_oxy_loss(oxygen_damage)
	tracked_mob.blood_volume = stored_blood_volume

	return TRUE

/datum/component/damage_tracker/Initialize(...)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	update_damage_values()

/datum/component/damage_tracker/Destroy(force, silent)
	if(reapply_damage_on_removal)
		reapply_damage()

	return ..()

/// This does the same as it's parent, but it also tracks organ damage.
/datum/component/damage_tracker/human
	/// How much damage does the owner's heart currently have?
	var/heart_damage
	/// How much damage does the owner's liver currently have?
	var/liver_damage
	/// How much damage does the owner's lungs currently have?
	var/lung_damage
	/// How much damage does the owner's stomach currently have?
	var/stomach_damage
	/// How much damage does the owner's brain currently have?
	var/brain_damage
	/// How much damage does the owner's eyes currently have?
	var/eye_damage
	/// How much damage does the owner's ears currently have?
	var/ear_damage

	/// What brain traumas does the owner currently have?
	var/list/trauma_list = list()

	/// What wounds does the owner currently have?
	var/list/wound_list = list()

/datum/component/damage_tracker/human/update_damage_values()
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(!. || !istype(human_parent))
		return FALSE

	var/list/current_trauma_list = human_parent.get_traumas()
	if(length(current_trauma_list))
		trauma_list = current_trauma_list.Copy()

	for(var/obj/item/bodypart/limb as anything in human_parent.get_wounded_bodyparts())
		for(var/datum/wound/limb_wound as anything in limb.wounds)
			if(!islist(wound_list[limb.type]))
				wound_list[limb.type] = list()
			wound_list[limb.type] |= limb_wound.type

	heart_damage = human_parent.check_organ_damage(/obj/item/organ/heart)
	liver_damage = human_parent.check_organ_damage(/obj/item/organ/liver)
	lung_damage = human_parent.check_organ_damage(/obj/item/organ/lungs)
	stomach_damage = human_parent.check_organ_damage(/obj/item/organ/stomach)
	brain_damage = human_parent.check_organ_damage(/obj/item/organ/brain)
	eye_damage = human_parent.check_organ_damage(/obj/item/organ/eyes)
	ear_damage = human_parent.check_organ_damage(/obj/item/organ/ears)

	return TRUE

/datum/component/damage_tracker/human/reapply_damage()
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(!. || !istype(human_parent))
		return FALSE

	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_HEART, heart_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_LIVER, liver_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_LUNGS, lung_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_STOMACH, stomach_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_EYES, eye_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_EARS, ear_damage)
	human_parent.restore_tracked_organ_damage(ORGAN_SLOT_BRAIN, brain_damage)

	var/obj/item/organ/brain/human_brain = human_parent.get_organ_by_type(/obj/item/organ/brain)
	if(!human_brain)
		return FALSE

	var/list/current_trauma_list = human_parent.get_traumas()
	for(var/datum/brain_trauma/trauma_to_add as anything in trauma_list)
		if(trauma_to_add in current_trauma_list)
			continue // We don't need to torture the poor soul with the same brain trauma.

		human_brain.gain_trauma(trauma_to_add)

	for(var/obj/item/bodypart/limb_type as anything in wound_list)
		var/obj/item/bodypart/limb_instance = locate(limb_type) in human_parent.bodyparts
		if(!limb_instance)
			continue
		for(var/datum/wound/wound_type as anything in wound_list[limb_type])
			var/datum/wound/new_wound = new wound_type()
			new_wound.apply_wound(limb_instance, TRUE)

	return TRUE

/datum/component/damage_tracker/human/Initialize(...)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	return ..()

/// Returns the damage of the `organ_to_check`, or a special value describing why the organ isn't there.
/mob/living/carbon/human/proc/check_organ_damage(obj/item/organ/organ_to_check)
	var/obj/item/organ/organ_to_track = get_organ_by_type(organ_to_check)
	if(organ_to_track)
		return organ_to_track.damage

	// a species that never grows this organ isn't hurt, it's just built that way, so there's no injury to carry across
	if(isnull(dna?.species?.get_mutant_organ_type_for_slot(organ_to_check::slot)))
		return ORGAN_ABSENCE_SPECIES_NORMAL

	return ORGAN_ABSENCE_INJURY

/// Puts a tracked damage value back onto an organ
/mob/living/carbon/human/proc/restore_tracked_organ_damage(organ_slot, stored_damage)
	if(stored_damage == ORGAN_ABSENCE_SPECIES_NORMAL)
		return

	var/obj/item/organ/organ_to_damage = get_organ_slot(organ_slot)
	if(!organ_to_damage)
		return

	if(stored_damage == ORGAN_ABSENCE_INJURY)
		stored_damage = max(organ_to_damage.maxHealth - 1, 0)

	set_organ_loss(organ_slot, stored_damage)

#undef ORGAN_ABSENCE_INJURY
#undef ORGAN_ABSENCE_SPECIES_NORMAL
