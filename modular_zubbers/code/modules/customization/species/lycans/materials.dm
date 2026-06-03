/*
//Silver debuff Code vs Lycans temporarily disabled for for the bane refactor.

/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()

	if (isitem(source))
		source.AddElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)

/datum/material/silver/on_removed(atom/source, mat_amount, multiplier, from_slot)
	. = ..()

	source.RemoveElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)

 */
