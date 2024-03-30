/obj/item/storage/bag/garment/blueshield
	name = "blueshield's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the blueshield."

/obj/item/storage/bag/garment/blueshield/PopulateContents()
	new /obj/item/clothing/neck/mantle/bsmantle(src)
	new /obj/effect/spawner/random/blueshield_random(src)

/obj/structure/closet/secure_closet/blueshield
	name = "blueshield's locker"
	icon_state = "bs"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/storage/medkit/tactical/blueshield(src)
//	new /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo(src) happy BUBBERSTATION APRIL DAY
//	new /obj/item/storage/bag/garment/blueshield(src)
//	new /obj/item/mod/control/pre_equipped/blueshield(src)
