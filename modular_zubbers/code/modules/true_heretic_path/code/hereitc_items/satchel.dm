/obj/item/storage/backpack/satchel/leather/exile
	name = "satchel of looting"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/backpack/satchel/leather/exile/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 60
	atom_storage.max_total_storage = 60
	atom_storage.numerical_stacking = TRUE
	atom_storage.allow_quick_gather = TRUE
	atom_storage.allow_quick_empty = TRUE
	atom_storage.set_holdable(list(
		/obj/item/heretic_currency
	))