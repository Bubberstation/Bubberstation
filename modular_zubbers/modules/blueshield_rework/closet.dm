/obj/item/storage/bag/garment/blueshield/PopulateContents()
	. = ..()
	new /obj/item/clothing/suit/jacket/det_suit/noir/blueshield(src)
	new /obj/item/clothing/shoes/laceup/blueshield(src)
	new /obj/item/clothing/glasses/sunglasses(src)

/obj/structure/closet/secure_closet/blueshield/New()
	. = ..()
	new /obj/item/radio/headset/headset_bs(src)
	new /obj/item/radio/headset/headset_bs/alt(src)
	new /obj/item/storage/bag/garment/blueshield(src)
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/box/zipties(src)
	new /obj/item/storage/medkit/regular(src)
	new /obj/item/storage/belt/holster/detective/blueshield/full(src)
	new /obj/item/clothing/gloves/tackler/rocket/blueshield(src)
	new /obj/item/storage/box/pinpointer_pairs(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/clothing/neck/tie/blue/blueshield(src)

/obj/machinery/vending/access/command/build_access_list(list/access_lists)
	. = ..()
	access_lists["[ACCESS_CAPTAIN]"] += list(
		/obj/item/clothing/suit/jacket/det_suit/noir/blueshield = 1,
		/obj/item/clothing/shoes/laceup/blueshield = 1,
		/obj/item/clothing/glasses/sunglasses = 1
	)