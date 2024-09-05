/datum/uplink_item/badass/syndimaid
	name = "Syndicate Maid Outfit"
	desc = "A very obvious joke. A standard syndicate maid suit with bulky armor added to it. The added armor prevents you from wearing any extra outerwear"
	item = /obj/item/storage/box/syndimaid
	cost = 8 // Same as the redsuit mod. It's worse than it in almost every way but that's by design
	cant_discount = TRUE
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/obj/item/storage/box/syndimaid
	name = "box of neatly packaged laundry"

/obj/item/storage/box/syndimaid/PopulateContents()
	. = ..()
	new /obj/item/clothing/under/syndicate/skyrat/maid/armored(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate/armored(src)
	new /obj/item/clothing/gloves/combat/maid/armored(src)
	new /obj/item/clothing/shoes/jackboots/heel/tactical(src)
