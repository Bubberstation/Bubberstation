/obj/item/storage/box/gunset/m1911_captains
	name = "m1911 gunset"
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
	desc = "A heavy hitting pistol made for only the most prestigious of nanotrasen officers"
	icon = 'modular_zubbers/icons/obj/reshicaptainpistol.dmi'
	icon_state = "m1911"

/obj/item/gun/ballistic/automatic/pistol/m1911/captains/no_mag //USE THIS ONE
	spawnwithmagazine = 0
