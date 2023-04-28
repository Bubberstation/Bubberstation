/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS 'Wood Pecker'"
	desc = "A medium sized revolver used by Romulus Officers prior to the destruction of the planet, this one is a military spec variant chambered in the high velocity .460 rowland magnum."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rowland
	icon = 'modular_zubbers/icons/obj/reshi40x32.dmi'
	icon_state = "microtracker"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	company_flag = COMPANY_ROMULUS

/obj/item/ammo_box/magazine/internal/cylinder/rowland
	name = "\improper rowland revolver cylinder"
	max_ammo = 7
	ammo_type = /obj/item/ammo_casing/b460
	caliber = CALIBER_460

/obj/item/gun/ballistic/revolver/hos_revolver/big
	name = "\improper HR-460OS 'Tracker'"
	desc = "A brutally effectve revolver by Romulus officers prior to destruction of the planet, While not as powerful as their Nanotrasen counterpart, the high-velocity bullet swiftly dispatch armoured target. Chambered in .460 Rowland Magnum."
	icon = 'modular_zubbers/icons/obj/reshirevolver.dmi'
	icon_state = "tracker"
	projectile_damage_multiplier = 1.6


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
	atom_storage.max_total_storage = 35
	atom_storage.max_slots = 35
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
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)

//TEST THIS OUT WHEN NEEDED

/obj/item/choice_beacon/head_of_security
	name = "gun choice beacon"
	desc = "whatever you choose will determine the outcome of space station 13. so choose wisely."
	company_source = "Romulus Shipping Company"
	company_message = span_bold("Copy that SS13, supply pod enroute!")


/obj/item/choice_beacon/head_of_security/generate_display_names()
	var/static/list/hosgun_list
	if(!hosgun_list)
		hosgun_list = list()
		for(var/obj/item/storage/box/hosgun/box as anything in typesof(/obj/item/storage/box/hosgun))
			hosgun_list[initial(box.name)] = box
	return hosgun_list

/obj/item/storage/box/hosgun
	name = "Classic 3-round burst pistol 9mm"

/obj/item/storage/box/hosgun/PopulateContents()
	new /obj/item/storage/box/gunset/glock18_hos(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/storage/box/hecu_rations(src)
	new /obj/item/storage/fancy/cigarettes/cigars(src)

/obj/item/storage/box/hosgun/revolver
	name = "Romulus Officer Heavy Revolver .460"

/obj/item/storage/box/hosgun/revolver/PopulateContents()
	new /obj/item/storage/box/gunset/hos_revolver(src)
	new	/obj/item/clothing/neck/cloak/hos/redsec(src)
	new /obj/item/clothing/under/rank/security/head_of_security/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/shoes/jackboots/sec/redsec(src)
	new /obj/item/storage/box/nri_rations(src)
	new /obj/item/knife/combat(src)

/obj/item/storage/box/hosgun/glock
	name = "Solaris International Contractor Dual .45 Pistol"

/obj/item/storage/box/hosgun/glock/PopulateContents()
	new /obj/item/storage/box/gunset/m1911_captains(src)
	new /obj/item/storage/box/gunset/m1911_captains(src)
	new /obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/storage/pill_bottle/probital(src)

/obj/item/paper/hos_gun_notes
	name = "READ THIS"
	default_raw_text = {"HOS Note<br>
	Congratulation on your assignment to space station 13.<br>
	You are given the choices between one of our three heroes from the past!<br>
	Yes, you did read that correctly. I'm sure you're excited.<br>
	Classic Head of Security; It contains the Glock 18, a box of cigar and two box of ammo for your pistol, You can print more from autolathe or if you were to purchase OR research the lethal ammunition disk<br>
	Romulus Officer; It contains the Heavy Revolver .460 Military Spec, a rare revolver from romulus chambered in .460 Rowland Magnum, you'll get no speedloader but atleast you get pouches to reload it with. Comes with the classic red security loadout<br>
	Solaris International Contractor; Contains two M1911 Custom originally intended as replacement of the captain pistol, comes with an expensive necktie and the chief of police uniform. Painkiller included.<br>
	- Rowley"}

//Special Ammo for 460

/obj/item/ammo_casing/b460/hp
	name = ".460 Rowland Magnum Hollow Point bullet casing"
	desc = "A .460 Rowland magnum casing."
	projectile_type = /obj/projectile/bullet/b460/hp

/obj/projectile/bullet/b460/hp
	name = ".460 RM Low Velocity Hollow Point bullet"
	damage = 60
	bare_wound_bonus = 40
	speed = 2.4 //Slow so you can dodge

