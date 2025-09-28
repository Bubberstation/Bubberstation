/////GS13 - reflavoring of random items into GATO corp, mostly seperated variants so we don't overwrite NT

/obj/item/storage/fancy/cigarettes/gatito
	name = "\improper HumoGatitos packet"
	desc = "Strangely tasty for a cigarette."
	icon = 'modular_gs/icons/obj/cigarettes.dmi'
	icon_state = "smokegatitos"
	spawn_type = /obj/item/clothing/mask/cigarette/gatito

/obj/item/clothing/mask/cigarette/gatito
	desc = "A HumoGatitos brand cigarette."

/obj/item/banner/gato
	name = "GATO banner"
	desc = "The banner of GATO, our corporate overlords."
	icon = 'modular_gs/icons/obj/items_and_weapons.dmi'
	icon_state = "banner_gato"
	job_loyalties = list("Command")
	warcry = "FOR THE INTEREST OF GATO!!"
	lefthand_file = 'modular_gs/icons/mob/inhands/equipment/banners_lefthand.dmi'
	righthand_file = 'modular_gs/icons/mob/inhands/equipment/banners_righthand.dmi'

/obj/item/soap/gato
	desc = "A heavy duty bar of GATO brand soap. Smells like raspberries"
	grind_results = list(/datum/reagent/consumable/berryjuice = 10, /datum/reagent/lye = 10)
	icon = 'modular_gs/icons/obj/items_and_weapons.dmi'
	icon_state = "soapgt"
	inhand_icon_state = "soapgt"
	worn_icon_state = "soapgt"
	cleanspeed = 2.8 SECONDS
	uses = 300

/obj/item/toy/cards/deck/gato
	desc = "A deck of GATO-branded space-grade playing cards."
	icon = 'modular_gs/icons/obj/toy.dmi'

/obj/item/bedsheet/gato
	icon = 'modular_gs/icons/obj/bedsheets.dmi'
	icon_state = "sheetgato"
	worn_icon_state = "sheetpurple"

/obj/item/bedsheet/gato/double
	icon = 'modular_gs/icons/obj/bedsheets.dmi'
	icon_state = "double_sheetgato"
	worn_icon_state = "sheetpurple"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/structure/sign/gato
	name = "GATO Logo"
	desc = "A sign with the GATO Logo on it. Glory to GATO!"
	icon = 'modular_gs/icons/obj/gatofication.dmi'
	icon_state = "gato"

//gato decal, should be moved elsewhere tbh
/obj/effect/decal/big_gato //96x96 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'modular_gs/icons/turf/96x96.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_x = -32
	pixel_y = -32

/obj/effect/decal/medium_gato //64x64 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'modular_gs/icons/turf/64x64.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_y = -16
	pixel_x = -16
