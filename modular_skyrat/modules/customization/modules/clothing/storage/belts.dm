/obj/item/storage/belt/medbandolier
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "medical bandolier"
	desc = "A pocketed, pine green belt slung like a sash over the shoulder. Features numerous pockets for medicines and poisons alike. Now is coward healing time."
	icon_state = "med_bandolier"
	worn_icon_state = "med_bandolier"

/obj/item/storage/belt/medbandolier/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 14
	atom_storage.max_total_storage = 35
	atom_storage.set_holdable(list(
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/storage/pill_bottle,
		/obj/item/implanter,
		/obj/item/hypospray,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/cup/vial,
		/obj/item/weaponcell/medical,
		/obj/item/reagent_containers/cup/tube
		))
