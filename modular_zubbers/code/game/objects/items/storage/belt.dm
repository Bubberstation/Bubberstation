/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing/shotgun,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/flashlight/seclite,
		/obj/item/food/donut,
		/obj/item/grenade,
		/obj/item/gun, //SKYRAT EDIT ADDITION
		/obj/item/holosign_creator/security,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/radio,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/stock_parts/power_store/cell/microfusion, //SKYRAT EDIT ADDITION
	))
	atom_storage.open_sound = 'sound/items/handling/holster_open.ogg'
	atom_storage.open_sound_vary = TRUE
	atom_storage.rustle_sound = null
	atom_storage.cant_hold = typecacheof(list(/obj/item/gun/ballistic/automatic/rom_flech, /obj/item/gun/syringe, /obj/item/gun/chem, /obj/item/gun/ballistic/automatic/ar, /obj/item/gun/magic/wand)
