/obj/item/mod/module/hydraulic/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/hydraulic/on_part_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)
