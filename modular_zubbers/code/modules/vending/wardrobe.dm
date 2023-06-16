/obj/machinery/vending/wardrobe/sec_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/head/helmet/metrocophelmet = 5,
		/obj/item/clothing/suit/armor/metrocop = 5,
	)
	premium += list(
		/obj/item/clothing/suit/armor/metrocopriot = 1,
	)
	. = ..()

