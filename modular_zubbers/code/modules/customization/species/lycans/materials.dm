/obj/item/apply_material_effects(list/materials)
	. = ..()

	for (var/datum/material/silver/found_silver_datum in materials)
		AddElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)
		break
