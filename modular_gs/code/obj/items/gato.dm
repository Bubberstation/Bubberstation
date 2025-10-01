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

/obj/structure/sign/gato
	name = "GATO Logo"
	desc = "A sign with the GATO Logo on it. Glory to GATO!"
	icon = 'modular_gs/icons/obj/gatofication.dmi'
	icon_state = "gato"

/obj/structure/sign/gatofull_1
	name = "GATO"
	desc = "GATO - expand your horizons!"
	icon = 'modular_gs/icons/obj/signs.dmi'
	icon_state = "gato_sign_1"

/obj/structure/sign/gatofull_2
	name = "GATO"
	desc = "GATO - expand your horizons!"
	icon = 'modular_gs/icons/obj/signs.dmi'
	icon_state = "gato_sign_2"

/obj/structure/sign/gatofull_3
	name = "GATO"
	desc = "GATO - expand your horizons!"
	icon = 'modular_gs/icons/obj/signs.dmi'
	icon_state = "gato_sign_3"

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

/obj/structure/shipping_container/gato
	name = "\improper GATO shipping container"
	desc = "A standard-measure shipping container for bulk transport of goods. This one is from GATO - it could carry anything, ranging from simple food supplies to nutri-tech gear."
	icon = 'modular_gs/icons/obj/containers.dmi'
	icon_state = "gtfid"

/obj/structure/shipping_container/gato2
	name = "\improper GATO shipping container"
	desc = "A standard-measure shipping container for bulk transport of goods. This one is from GATO - it could carry anything, ranging from simple food supplies to nutri-tech gear."
	icon = 'modular_gs/icons/obj/containers.dmi'
	icon_state = "gato"

/obj/structure/shipping_container/gato_defaced
	name = "\improper Defaced GATO shipping container"
	desc = "A standard-measure shipping container for bulk transport of goods. This one is from GATO - it could carry anything, ranging from simple food supplies to nutri-tech gear."
	icon = 'modular_gs/icons/obj/containers.dmi'
	icon_state = "gtfid_defaced"

/obj/structure/closet/body_bag/environmental/gato
	name = "elite environmental protection bag"
	desc = "A heavily reinforced and insulated bag, capable of fully isolating its contents from external factors."
	icon = 'modular_gs/icons/obj/medical.dmi'
	icon_state = "gtenvirobag"
	contents_pressure_protection = 1
	contents_thermal_insulation = 1
	foldedbag_path = /obj/item/bodybag/environmental/gato
	weather_protection = list(TRAIT_WEATHER_IMMUNE)

/obj/item/bodybag/environmental/gato
	name = "elite environmental protection bag"
	desc = "A folded, heavily reinforced, and insulated bag, capable of fully isolating its contents from external factors."
	icon = 'modular_gs/icons/obj/medical.dmi'
	icon_state = "ntenvirobag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/gato
	resistance_flags = ACID_PROOF | FIRE_PROOF | FREEZE_PROOF | LAVA_PROOF

/obj/item/sign/flag/gato
	name = "folded flag of the GATO"
	desc = "The folded flag of the GATO."
	icon = 'modular_gs/icons/obj/gatofication.dmi'
	icon_state = "folded_gt"
	sign_path = /obj/structure/sign/flag/gato

/obj/structure/sign/flag/gato
	name = "flag of GATO"
	desc = "The official corporate flag of GATO. Mostly flown as a ceremonial piece, or to mark land on a new frontier."
	icon = 'modular_gs/icons/obj/gatofication.dmi'
	icon_state = "flag_gt"


//gs13 - bedsheets
/obj/item/bedsheet/gato //GS13
	name = "GATO Bedsheet"
	desc = "Extra padding, for extra comfiness."
	icon_state = "sheetgato"
	dream_messages = list("GATO", "capitalism", "meow",)
	icon = 'modular_gs/icons/obj/bedsheets.dmi'
	worn_icon_state = "sheetpurple"

/obj/item/bedsheet/double_gato //GS13
	name = "Double GATO Bedsheet"
	desc = "Extra padding, for extra comfiness. Mega sized, for mega cuddles."
	icon_state = "doublesheet_gato"
	dream_messages = list("GATO", "capitalism", "meow",)
	icon = 'modular_gs/icons/obj/bedsheets.dmi'
	bedsheet_type = BEDSHEET_DOUBLE
	worn_icon_state = "sheetpurple"
