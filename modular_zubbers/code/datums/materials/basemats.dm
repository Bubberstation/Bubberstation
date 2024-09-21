/datum/material/silver/on_applied(atom/source, amount, material_flags)
	. = ..()
	source.AddElement(/datum/element/bane, mob_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)

/datum/material/silver/on_removed(atom/source, amount, material_flags)
	. = ..()
	source.RemoveElement(/datum/element/bane, mob_biotypes = MOB_VAMPIRIC, damage_multiplier = 0.5)
