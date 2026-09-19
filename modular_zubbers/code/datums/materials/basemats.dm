/*
//Silver debuff Code vs Lycans temporarily disabled for for the bane refactor.

/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.AddComponent(/datum/component/bane, affected_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)

/datum/material/silver/on_removed(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.RemoveComponentSource(/datum/component/bane, affected_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)
 */
