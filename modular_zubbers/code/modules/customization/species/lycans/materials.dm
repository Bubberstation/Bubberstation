/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()

	if (isitem(source))
		source.AddComponent(/datum/component/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)

/* /datum/material/silver/on_removed(atom/source, mat_amount, multiplier, from_slot)
	. = ..()

	source.RemoveElementSource(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)

//this component should be removed when silver is naturally removed, it should be possible for silver to be removed without this proc being called.
 */
