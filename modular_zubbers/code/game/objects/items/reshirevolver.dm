/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS 'Tracker'"
	desc = "A brutally effectve revolver by Romulus officers prior to destruction of the planet, if the initial damage did not kill, the bleedout would. Uses the brutal .460 Rowland ammo."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rowland
	icon = 'modular_zubbers/icons/obj/reshirevolver.dmi'
	icon_state = "tracker"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	projectile_damage_multiplier = 1.6 //48 Damages, still a lot but not too much
//With the damage multipler, it would crit in 4, kill in 6. Does not take into account armours.

/obj/item/ammo_box/magazine/internal/cylinder/rowland
	name = "\improper rowland revolver cylinder"
	max_ammo = 6
	ammo_type = /obj/item/ammo_casing/b460
	caliber = CALIBER_460

/obj/item/storage/bag/b460reloadpouch
	name = "reload pouch"
	desc = "A pouch for holding loose casings for .460 Rowland ammo. incompatible with anything else. Fit on your belt too"
	icon = 'modular_zubbers/icons/obj/pouches.dmi'
	icon_state = "reloadpouch"
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/b460reloadpouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 30
	atom_storage.max_slots = 30
	atom_storage.numerical_stacking = TRUE
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/b460,
		))

/obj/item/storage/bag/b460reloadpouch/PopulateContents()
	. = ..()
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)
	new /obj/item/ammo_casing/b460(src)

/obj/item/storage/box/gunset/hos_revolver/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)
