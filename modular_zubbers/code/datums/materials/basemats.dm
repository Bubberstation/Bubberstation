/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.AddElement(/datum/element/bane, mob_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)

/datum/material/silver/on_removed(atom/source, mat_amount, multiplier, from_slot)
	. = ..()
	source.RemoveElement(/datum/element/bane, mob_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)
