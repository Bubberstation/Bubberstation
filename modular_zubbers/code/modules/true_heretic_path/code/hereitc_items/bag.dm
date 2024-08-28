/obj/item/storage/bag/exile
	name = "small rucksack of looting"

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_bags.dmi'
	icon_state = "rucksack"

	w_class = WEIGHT_CLASS_NORMAL //YOU FUCKING LIAR. YOU SAID IT WAS SMALL.

/obj/item/storage/bag/exile/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 60
	atom_storage.max_total_storage = 60
	atom_storage.numerical_stacking = TRUE
	atom_storage.allow_quick_gather = TRUE
	atom_storage.allow_quick_empty = TRUE
	atom_storage.set_holdable(/obj/item/heretic_currency)
