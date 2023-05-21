/obj/item/storage/box/gunset/m1911_captains
	name = "m1911c gunset"
	desc = "contain a rather heavy pistol"

/obj/item/storage/box/gunset/m1911_captains/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/captains/no_mag(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/gun/ballistic/automatic/pistol/m1911/captains
	name = "m1911c"
	desc = "A heavy hitting pistol made for only the most prestigious of nanotrasen officers. Custom produced by Romulus Technology"
	icon = 'modular_zubbers/icons/obj/reshicaptainpistol.dmi'
	icon_state = "m1911"
	company_flag = COMPANY_ROMULUS

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/no_mag //USE THIS ONE
	spawnwithmagazine = 0

//Devil may cry reference here

/obj/item/storage/box/gunset/m1911red_hos
	name = "m1911c red gunset"
	desc = "contain a rather heavy pistol"

/obj/item/storage/box/gunset/m1911red_hos/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/captains/red/nomag(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)

/obj/item/storage/box/gunset/m1911blue_hos
	name = "m1911c blue gunset"
	desc = "contain a rather heavy pistol"

/obj/item/storage/box/gunset/m1911blue_hos/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/captains/blue/nomag(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/red
	name = "M1911OS 'Bonnie'"
	desc = "A slow heavy hitting pistol for those that favours accuracy, chambered in .460 and stamped with genuine gold and the grips are made of rare Romulus taiga woods"
	icon_state = "m1911red"
	mag_type = /obj/item/ammo_box/magazine/m45a5
	fire_delay = 4.25
	dual_wield_spread = 1

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/blue
	name = "M1911MS 'Clyde'"
	desc = "A fast heavy hitting pistol for those that favours burst damages output over precision, chambered in .45 and stamped with some sort of glowing blue metal in the shape of Romulus Technology logo."
	icon_state = "m1911blue"
	burst_size = 3
	fire_delay = 2.15
	spread = 4
	semi_auto = TRUE
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT)
	dual_wield_spread = 1 //Wouldn't make sense they're unviable to use at the same time

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/red/nomag
	spawnwithmagazine = 0

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/blue/nomag
	spawnwithmagazine = 0
