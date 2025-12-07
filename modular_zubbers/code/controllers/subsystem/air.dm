/datum/controller/subsystem/air/
	var/datum/reagent/chosen_goblin_reagent_medicine
	var/datum/reagent/chosen_goblin_reagent_drug
	var/datum/reagent/chosen_goblin_reagent_toxic

/datum/controller/subsystem/air/Initialize()
	. = ..()

	// Precompute these for the entire round - fallback on salt.
	chosen_goblin_reagent_medicine = pick(get_synthesizable_reagent_subtypes(/datum/reagent/medicine)) || /datum/reagent/consumable/salt
	chosen_goblin_reagent_drug = pick(get_synthesizable_reagent_subtypes(/datum/reagent/drug)) || /datum/reagent/consumable/salt
	chosen_goblin_reagent_toxic = pick(get_synthesizable_reagent_subtypes(/datum/reagent/toxin)) || /datum/reagent/consumable/salt

/// Returns a list of all subtypes of base_type reagent that can be synthesized.
/// If none qualify, returns an empty list — caller should handle fallback.
/proc/get_synthesizable_reagent_subtypes(base_type)
	var/list/reagent_subtypes = subtypesof(base_type)
	if(!reagent_subtypes.len)
		return list()

	// Filter in-place
	for(var/i = reagent_subtypes.len; i >= 1; i--)
		var/datum/reagent/reagent = reagent_subtypes[i]
		if (!(initial(reagent.chemical_flags) & REAGENT_CAN_BE_SYNTHESIZED))
			reagent_subtypes.Cut(i, i+1) // remove this entry

	return reagent_subtypes
