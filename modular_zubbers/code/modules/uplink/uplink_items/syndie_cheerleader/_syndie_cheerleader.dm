// Syndicate Cheerleader Outfit - Traitor Uplink Entry

/datum/uplink_item/badass/syndie_cheerleader
	name = "Syndicate Cheerleader Outfit"
	desc = "Cybersun Industries is proud to support operative wellness. \
		Studies show that having someone in your corner makes contract completion 12% more likely."
	item = /obj/item/storage/box/syndie_cheerleader
	cost = 6
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/obj/item/storage/box/syndie_cheerleader
	name = "suspicious red box"
	desc = "A sleek, sturdy box. The Cybersun logo is printed on the side for some reason."
	icon_state = "syndiebox"

/obj/item/storage/box/syndie_cheerleader/PopulateContents()
	. = ..()
	new /obj/item/clothing/under/syndicate/ba_cheerleader(src)
	new /obj/item/clothing/gloves/ba_cheerleader/syndicate(src)
	new /obj/item/clothing/shoes/sneakers/ba_cheerleader/syndicate(src)
