/obj/item/storage/bag/garment/blueshield
	name = "blueshield's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the blueshield."

/obj/item/storage/bag/garment/blueshield/PopulateContents()
	new /obj/item/clothing/neck/mantle/bsmantle(src)


/obj/structure/closet/secure_closet/blueshield
	name = "blueshield's locker"
	icon_state = "bs"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/storage/belt/security(src) // We took your equipment, sorry :*
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/storage/medkit/tactical/blueshield(src)
//	new /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo(src) happy BUBBERSTATION APRIL DAY
//	new /obj/item/storage/bag/garment/blueshield(src)
	for(var/i = 0, i<7, i++)
		new /obj/item/choice_beacon/blueshield(src)
