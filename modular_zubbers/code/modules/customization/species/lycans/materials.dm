/obj/item/apply_material_effects(list/materials)
	. = ..()

	if (QDELETED(src))
		// oddly, deleting a gun seems to initialize materials on its ammo... causing the element to be added after qdel
		// odd. but we can just check for qdeletion to catch this edge case
		return

	// in case we've remove materials
	RemoveElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)

	for (var/datum/material/silver/found_silver_datum in materials)
		AddElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 2, requires_combat_mode = FALSE, bane_damage_override = BURN)
		break
