/// How much damage is done to the NIF if the user ends the round with it uninstalled?
#define LOSS_WITH_NIF_UNINSTALLED 25

/datum/modular_persistence
	// These are not handled by the prefs system. They are just stored here for convienience.
	/// The path to the current implanted NIF. Can be null.
	var/nif_path
	/// The current durability of the implanted NIF. Can be null.
	var/nif_durability
	/// The extra examine text for the user of the NIF. Can be null.
	var/nif_examine_text
	/// The theme of the implanted NIF. Can be null.
	var/nif_theme
	/// Whether the NIF is calibrated for use or not. Can be null.
	var/nif_is_calibrated

/// Saves the NIF data for a individual user.
/mob/living/carbon/human/proc/save_nif_data(datum/modular_persistence/persistence)
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)

	if(HAS_TRAIT(src, GHOSTROLE_TRAIT)) //Nothing is lost from playing a ghost role
		return FALSE

	if(!installed_nif || (installed_nif && !installed_nif.nif_persistence)) // If you have a NIF on file but leave the round without one installed, you only take a durability loss instead of losing the implant.
		if(persistence.nif_path)
			if(persistence.nif_durability <= 0) //There is one round to repair the NIF after it breaks, otherwise it will be lost.
				persistence.nif_path = null
				persistence.nif_examine_text = null
				persistence.nif_durability = null
				return

			persistence.nif_durability = max((persistence.nif_durability - LOSS_WITH_NIF_UNINSTALLED), 0)
			return

		persistence.nif_path = null
		persistence.nif_examine_text = null
		return

	persistence.nif_path = installed_nif.type
	persistence.nif_durability = installed_nif.durability
	persistence.nif_theme = installed_nif.current_theme
	persistence.nif_is_calibrated = installed_nif.is_calibrated

	var/datum/component/nif_examine/examine_component = GetComponent(/datum/component/nif_examine)

	persistence.nif_examine_text = examine_component?.nif_examine_text
	for(var/datum/nifsoft/nifsoft as anything in installed_nif.loaded_nifsofts)
		if(!nifsoft.persistence)
			continue

		nifsoft.save_persistence_data(persistence)


/// Loads the NIF data for an individual user.
/mob/living/carbon/human/proc/load_nif_data(datum/modular_persistence/persistence)
	if(HAS_TRAIT(src, GHOSTROLE_TRAIT))
		return FALSE

	if(!persistence.nif_path)
		return

	var/obj/item/organ/internal/cyberimp/brain/nif/new_nif = new persistence.nif_path

	new_nif.durability = persistence.nif_durability
	new_nif.current_theme = persistence.nif_theme
	new_nif.is_calibrated = persistence.nif_is_calibrated
	new_nif.Insert(src)

	var/datum/component/nif_examine/examine_component = GetComponent(/datum/component/nif_examine)
	if(examine_component)
		examine_component.nif_examine_text = persistence.nif_examine_text

/// Loads the modular persistence data for a NIFSoft
/datum/nifsoft/proc/load_persistence_data()
	if(!linked_mob || !persistence)
		return FALSE
	var/obj/item/organ/internal/brain/linked_brain = linked_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!linked_brain || !linked_brain.modular_persistence)
		return FALSE

	return linked_brain.modular_persistence


/// Saves the modular persistence data for a NIFSoft
/datum/nifsoft/proc/save_persistence_data(datum/modular_persistence/persistence)
	if(!persistence)
		return FALSE

	return TRUE

#undef LOSS_WITH_NIF_UNINSTALLED
